module canny_edge_detection_tb;

reg clk, rst, start;


reg [15:0]image11, image12, image13;


reg [15:0]image21, image22, image23;


reg [15:0]image31, image32, image33;


wire data_appear;
wire  [15:0]res_img_x;

wire res_img_x_signed;

wire  [15:0]res_img_y;
wire res_img_y_signed;

wire [15:0]res_img_x_y;


reg [15:0]mem[0:589823];

integer file_id,k;


canny_edge_detection canny_iDUT(clk, rst, start, image11, image21, image31, image12, image22, image32, image13, image23, image33,
							res_img_x, res_img_x_signed, res_img_y, res_img_y_signed, res_img_x_y, data_appear);
                    
                    
                    
initial 
begin 
clk=0;
rst=0;
start=0;
end


always 
#20 clk=~clk;


initial
begin 
$readmemh("image_textfile_canny.txt",mem);
file_id=$fopen("edgefile_canny.txt");
end






initial 
begin 

#200; 


    for (k=0;k<589824;k=k+9) begin 
       @(negedge clk)  
       begin 
		rst=1; 
		start=1; 
		image11=mem[k];
		image21=mem[k+1];
		image31=mem[k+2];
		image12=mem[k+3];
		image22=mem[k+4];
		image32=mem[k+5];
		image13=mem[k+6];
		image23=mem[k+7];
		image33=mem[k+8];
       end
   end
   
   
@(negedge clk) start=0; 
  $fclose(file_id);
  $finish;            
end
 
       

	always @(negedge clk)
		begin 

			if(data_appear)
			begin 
				$fdisplay(file_id,"%d",res_img_x_y);
				$display("%d",res_img_x_y);
			end


		end

endmodule 
                    
