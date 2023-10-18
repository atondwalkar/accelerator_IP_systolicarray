system("perl systolicarray.pl -width 16 -dimension 4 -outfile ast_systolic_array_v.v");
system("mv ast_systolic_array_v.v ../accelerator_IP_systolicarray/accelerator_IP_systolicarray.srcs/sources_1/new/");
system("perl arrayIP.pl -width 16 -dimension 4 -outfile accelerator_IP_systolicarray.v");
system("mv accelerator_IP_systolicarray.v ../accelerator_IP_systolicarray/accelerator_IP_systolicarray.srcs/sources_1/new/");
