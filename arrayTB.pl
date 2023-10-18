use Getopt::Long;

#getting the user configuration
$command = GetOptions ( "help" => \$help,
            "param=s" => \$param,
            "width=i" => \$width,
            "dimension=i" => \$dimension,
            "outfile=s" => \$outfile );

#check for help
if($help > 0){
    Help();
    die;
}

# making sure either params file or other configs is specified
if((not defined $param) && ((not defined $width) or (not defined $dimension) or (not defined $outfile))) {
    ReturnError("Missing params");
}
elsif((defined $param) && ((defined $width) or (defined $dimension) or (defined $outfile))) {
    ReturnError("Command parameters shall either be a param file OR other input configs");
}

# parse the file into the variables or just parse the outfile
if( $param ne "" ) {
    ParseParams();
}

# check if outfile specified correctly
if($outfile =~ m/^(.+).sv/) { $outfile = $1; }
else {
    ReturnError("Outfile not speicifed properly <outfile>.sv");
}

# check for valid width
if($width < 1 || $width > 64 ) {
    ReturnError("Width out of bounds [1,64]");
}

# check for valid stage count
if($dimension < 2 || $dimension > 128 ) {
    ReturnError("Stages out of bounds [2,128]");
}

$datawidth = $width - 1;

Debugger();

GenerateRTL();

# print error and die
sub ReturnError {
    my ($ret) = @_;
    print "\n==Error==\n$ret\n==Error==\n\n";
    Help();
    die;
}

# subroutine for debugging perl
sub Debugger {
    print "Generating files with: width=$width, dimension=$dimension, outfile=$outfile\n";
}

# parse param file
sub ParseParams
{
    open($fh, "<", $param) or die("==Error== File $param not found");
    while(my $line = <$fh>) {
        if($line =~ m/\s*width\s*=\s*(\d+)\s*;\s*/) { $width = $1 }
        elsif($line =~ m/\s*stages\s*=\s*(\d+)\s*;\s*/) { $dimension = $1; }
        elsif($line =~ m/\s*outfile\s*=\s*(.+)\s*;\s*/) { $outfile = $1; }
    }
    close $fh;
}

sub GenerateRTL {
    # write the first part of the module
    $dimensionminus1 = $dimension - 1;

    # array for generation loops
    
    @a = (0..$dimensionminus1);

    open $fh, ">", $outfile.".sv";
    $message = <<"EOF";
//==========================================================
//      RTL Generated File
//      Author: Ashish Tondwalkar
//--------------------------------------------------
//      Description: TB for Systolic Array IP
//--------------------------------------------------
//      Datawidth = $width
//      Dimension = $dimension
//==========================================================



module system_TB_sv;

    parameter SIZE = 4;
	parameter DATAWIDTH = 16;

    logic clk, reset;
	logic start, busy;
	
    logic [SIZE-1:0][SIZE-1:0][DATAWIDTH-1:0] matrixA = '{'{5, 2, 6, 1},'{0, 6, 2, 0},'{3, 8, 1, 4},'{1, 8, 5, 6}};
    logic [SIZE-1:0][SIZE-1:0][DATAWIDTH-1:0] matrixB = '{'{7, 5, 8, 0},'{1, 8, 2, 6},'{9, 4, 3, 8},'{5, 3, 7, 9}};
    logic [SIZE-1:0][SIZE-1:0][DATAWIDTH-1:0] matrix_results;

    accelerator_IP_systolicarray DUT (
        .clk(clk),
        .reset(reset),
        .depth_A(4),
        .width_A(4),
        .depth_B(4),
        .width_B(4),
EOF
    print $fh $message;

    for my $row (@a) {
        for my $col (@a) {
            print $fh "        .a_in_$row\_$col\(matrixA[$row][$col])\,\n";
        }
    }

    for my $row (@a) {
        for my $col (@a) {
            print $fh "        .b_in_$row\_$col\(matrixB[$row][$col])\,\n";
        }
    }

    for my $row (@a) {
        for my $col (@a) {
            print $fh "        .dout_$row\_$col\(matrix_results[$row][$col])\,\n";
        }
    }

    $message = <<"EOF";
        .start(start),
        .done(done)
    );

integer i, j, k;


	initial begin 
		clk = 0;
		forever begin
		#10 clk = ~clk;
	end end 	
	 
	initial begin
		reset = 1;
		start = 0;
		#45;
		reset = 0;

		start = 1;
		#40;

		start = 0;
		#1000;
	
		\$stop;
	
	end
endmodule
	 
EOF
    print $fh $message;

}


#subroutine for helping user
sub Help {
    my $help = <<"EOF";
--param=param config file;

--width=datawidth
    width must be within range [1, 64]

--dimension=dimensions of the systolic array
    stages must be within range [2, 128]

--outfile=name of generated rtl and tb files

If a params file is specified, no other configuration inputs should be specified.

EOF
    print $help
}


=pod
 
=head1 NAME
 
B<ast4798.pl> - generate multistage pipelined shift register

=head1 SYNOPSIS

perl ast4798.pl [ARGUMENT(s)] ...

=head1 DESCRIPTION

Generates RTL and TB files in verilog for a multistage pipelilned shift register in verilog, given configuration parameters. TB tests reset and active function of RTL

ARGUMENTS(s) specified in the command line...

B<--help> display this help and exit

B<--param> specify a text file that defines the configuration arguments. If a file is specified, no other configuration arguments should be specified.

B<--width> configuration argument that defines the datawidth

B<--dimension> configuration argument that defines the array dimensions of the systolic array

B<--reset> configuration argument that defines the reset value for each stage register. Can be in decimal or hex.

B<--outfile> configuration argument that describes the nomenclature of the generate files. Must be specified with <module_name>.v

=head1 FILES

B<<module_name>.v> generated RTL

B<<module_name>_test.v> generated TB

=head1 EXAMPLES

perl ast4798.pl -param my_params.txt

perl ast4798.pl -width 16 -stages 32 -outfile ast_systolic_array.v

=head1 AUTHOR

Ashish Tondwalkar

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⡄⢀⣐⣶⣯⣴⣖⣲⣛⡻⢿⡷⠿⣯⣽⣶⣖⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣋⣽⣿⠟⢊⠉⣽⡿⠟⣫⣿⣯⣽⣞⡶⣶⣏⣿⣙⠳⢦⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣽⡻⣯⣿⣿⣿⣿⣲⣏⣽⣿⣿⣿⣿⣿⢯⠽⢿⣍⣛⠻⣯⣅⣀⡈⠙⢷⣄⠄⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣸⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⢿⠙⠻⣧⣜⡍⠹⡟⢻⣿⣏⣉⠳⠀⠙⢷⣤⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣽⣿⣿⣿⣿⣿⣿⣅⣿⢟⣷⡾⣛⣉⣟⣹⡿⣋⠓⠾⣢⣦⣭⡙⢻⡶⠾⠶⣄⠹⣯⣦⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣼⣻⣿⣿⣿⣿⣿⣿⣽⢿⣟⣥⠷⣍⣴⣿⢿⣬⣽⣭⣍⣩⣽⣟⣛⣻⣟⣽⣷⡤⣤⣙⢻⣯⡻⣮⣂⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣿⣶⣶⡽⠷⢾⡷⣿⣿⣉⣉⢛⠻⢗⣎⣻⠷⠾⣽⣗⡘⢿⣿⣿⢷⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣾⣻⠇⣼⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣍⣿⣿⣷⣛⠿⢿⣷⣭⣽⣿⣿⣿⣦⣽⣯⡁⠘⢿⡜⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢩⣿⣴⣿⢽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⣭⠼⣽⣛⠷⣗⣾⡿⠭⠿⢽⣿⣿⣄⠹⣦⢸⣇⡇
⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣴⣿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣟⠟⢛⡻⢿⣿⣟⣚⣻⡿⢿⣿⣿⣷⣶⣾⣇⠙⢧⣌⣸⡿⡇
⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⢻⣯⣾⣟⢽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣶⣿⣿⣿⣿⣯⣿⣿⣶⢿⣷⣿⡿⢻⣯⡻⣄⠉⠻⣷⠇
⠀⠀⠀⠀⠀⠀⠀⠀⣿⣟⣾⣿⣿⣿⢺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣷⡌⣲⣿⣦⣶⣶⣭⣿⣿⣷⠀⢿⡷
⠀⠀⠀⠀⠀⠀⠀⠀⡿⣿⣿⣿⣿⣿⣿⣿⡿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⡠⣹⣿⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿
⠀⠀⠀⠀⠀⠀⠀⠀⢳⣿⣿⣧⣿⣿⣿⣌⣧⣿⣿⣿⣟⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠗⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽
⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣾⣿⣼⣽⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⠑⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢿⡿⣽⣿⢿⣿⣿⠗⣿⣿⣿⣿⢯⡽⡋⢉⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢛⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣾⣧⣿⣯⣼⣿⣿⣀⣿⣿⣿⣿⣿⣗⣈⣉⣽⣾⣿⣿⣿⣿⣿⣿⣿⠚⠟⢿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⡄⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⣿⢻⣿⢿⣿⣿⣿⡟⣁⣛⣿⣿⣿⣷⣿⣿⣿⣻⣿⣿⢿⣿⣽⣿⣿⣦⡦⢼⣿⣿⣟⣿⣿⣿⡟⠉⢻⣾⢣⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣼⢿⡇⣿⣿⣾⣿⣿⣿⣷⣟⡻⢽⣿⣿⣿⣟⣛⣟⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢶⡎⣱⠒⠃⣾⢿⠏⠀
⠀⠀⠀⠀⠀⠀⠀⣴⣿⡿⠻⣿⣿⣿⣿⣿⣿⣿⣿⡗⠩⣿⡵⣿⣿⣿⣿⣿⣟⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⡉⢿⣿⠋⢀⣿⣿⠄⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢹⣿⠷⢾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⢿⣿⣿⢿⣿⡷⣿⣿⣿⣟⣟⢛⢿⣉⣁⢺⣿⣿⣈⡉⣿⣿⣲⣿⠏⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣠⢾⣿⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣷⣿⣿⡿⣿⠀⣙⣷⣿⣻⣿⡿⣿⣯⣿⣮⣼⣿⣿⣿⣹⣿⡿⠃⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡼⢛⣨⢾⣿⡾⢟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⠿⡿⠉⠛⠋⡻⠃⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀
⢴⠶⢶⣎⣩⣡⣽⣿⣿⡽⣾⣿⣿⣿⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣝⣿⡟⢋⢝⠉⠻⢿⣿⣴⣿⣿⣧⡴⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠒⠷⢖⠚⣟⣿⣿⡞⢻⣛⠟⡗⡾⡘⢻⣿⣿⣿⣿⣿⡛⢿⡿⠿⠟⢿⠛⠿⣿⣾⣿⣿⣶⣠⣷⣾⣿⡟⡻⣺⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀

Graduation is so close yet so far

=cut


