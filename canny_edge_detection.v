module canny_edge_detection(clk, rst, start, image11, image21, image31, image12, image22, image32, image13, image23, image33,
							res_img_x, res_img_x_signed, res_img_y, res_img_y_signed, res_img_x_y, data_appear);
    
    
    
input clk, rst, start;
//input rst;
//input start;

input [15:0]image11, image12, image13;
//input [15:0]im12;
//input [15:0]im13;

input [15:0]image21, image22, image23;
//input [15:0]im22;
//input [15:0]im23;

input [15:0]image31, image32, image33;
//input [15:0]im32;
//input [15:0]im33;

output [15:0]res_img_x;
output res_img_x_signed;

output [15:0]res_img_y;
output res_img_y_signed;
output [15:0]res_img_x_y;

output data_appear;

wire [15:0]res_img_x_y;
wire  [15:0]res_img_x;
wire res_img_x_signed;

wire  [15:0]res_img_y;
wire res_img_y_signed;



reg [15:0]image11_temp, image12_temp, image13_temp;
//reg [15:0]im12t;
//reg [15:0]im13t;

reg [15:0]image21_temp, image22_temp, image23_temp;
//reg [15:0]im22t;
//reg [15:0]im23t;

reg [15:0]image31_temp, image32_temp, image33_temp;
//reg [15:0]im32t;
//reg [15:0]im33t;



wire tmp_3x_signed;
wire [15:0]tmp_1x,tmp_2x,tmp_3x;

wire tmp_3y_signed;
wire [15:0]tmp_1y,tmp_2y,tmp_3y;



reg data_appear;
wire [15:0]reg_add;


              
              
assign res_img_y=tmp_3y;
assign res_img_y_signed =tmp_3y_signed;
assign tmp_1y=(image31_temp+(image32_temp << 1)+ image33_temp);
assign tmp_2y=(image11_temp+(image12_temp << 1)+ image13_temp);
assign tmp_3y=(tmp_1y > tmp_2y)?{tmp_1y-tmp_2y}:
              (tmp_1y < tmp_2y)?{tmp_2y-tmp_1y}:{16'd0};
     
assign tmp_3y_signed=(tmp_1y > tmp_2y)?1'b1:1'b0;
              
assign reg_add=(data_appear)?(res_img_x+res_img_y):16'd0;
assign res_img_x_y=(data_appear && reg_add >= 16'd255)?16'd255:16'd0;

assign res_img_x=tmp_3x;
assign res_img_x_signed=tmp_3x_signed;

assign tmp_1x=(image11_temp+(image21_temp << 1)+ image31_temp);
assign tmp_2x=(image13_temp+(image23_temp << 1)+ image33_temp);

assign tmp_3x=(tmp_1x > tmp_2x)?{tmp_1x-tmp_2x}:
              (tmp_1x < tmp_2x)?{tmp_2x-tmp_1x}:{16'd0};
           
assign tmp_3x_signed =(tmp_1x > tmp_2x)?1'b1:1'b0;

              
              




always @(posedge clk)
	begin 

		if(!rst)
 
			begin 
				image11_temp<=16'd0;
				image21_temp<=16'd0;
				image31_temp<=16'd0;
				image12_temp<=16'd0;
				image22_temp<=16'd0;
				image32_temp<=16'd0;
				image13_temp<=16'd0;
				image23_temp<=16'd0;
				image33_temp<=16'd0;
				data_appear<=1'b0;
			end

		else if(start )
			begin 

				image11_temp<=image11;
				image21_temp<=image21;
				image31_temp<=image31;
				image12_temp<=image12;
				image22_temp<=image22;
				image32_temp<=image32;
				image13_temp<=image13;
				image23_temp<=image23;
				image33_temp<=image33;
				data_appear<=1'b1;    
	end

else
begin
    image11_temp<=16'd0;
    image21_temp<=16'd0;
    image31_temp<=16'd0;
    image12_temp<=16'd0;
    image22_temp<=16'd0;
    image32_temp<=16'd0;
    image13_temp<=16'd0;
    image23_temp<=16'd0;
    image33_temp<=16'd0;
    data_appear<=1'b0;
    
end

end

endmodule     
