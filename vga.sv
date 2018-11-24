module vga(
    input wire i_clk,          
    input wire i_pix_stb,      
    output wire o_hs,           
    output wire o_vs,           
    output wire o_blanking,    
    output wire o_active,       
    output wire o_screenend,         
    output wire [9:0] o_x,      
    output wire [8:0] o_y       
    );

  
    localparam HS_STA = 16;              
    localparam HS_END = 16 + 96;         
    localparam HA_STA = 16 + 96 + 48;    
    localparam VS_STA = 480 + 11;       
    localparam VS_END = 480 + 11 + 2;    
    localparam VA_END = 480;             
    localparam LINE   = 800;             
    localparam SCREEN = 524;             

    reg [9:0] h_count;  
    reg [9:0] v_count;  

   
    assign o_hs = ~((h_count >= HS_STA) & (h_count < HS_END));
    assign o_vs = ~((v_count >= VS_STA) & (v_count < VS_END));

   
    assign o_x = (h_count < HA_STA) ? 0 : (h_count - HA_STA);
    assign o_y = (v_count >= VA_END) ? (VA_END - 1) : (v_count);


    assign o_blanking = ((h_count < HA_STA) | (v_count > VA_END - 1));

   
    assign o_active = ~((h_count < HA_STA) | (v_count > VA_END - 1)); 

   
    assign o_screenend = ((v_count == SCREEN - 1) & (h_count == LINE));


   

    always @ (posedge i_clk)
    begin
       
        if (i_pix_stb)  
        begin
            if (h_count == LINE) 
            begin
                h_count <= 0;
                v_count <= v_count + 1;
            end
            else 
                h_count <= h_count + 1;

            if (v_count == SCREEN) 
                v_count <= 0;
        end
    end
endmodule
