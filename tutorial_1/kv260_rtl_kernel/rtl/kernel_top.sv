module kernel_top #(
  parameter integer C_S_AXI_CONTROL_ADDR_WIDTH = 12 ,
  parameter integer C_S_AXI_CONTROL_DATA_WIDTH = 32 
)(

    // Clock/Reset/Control
    input  logic                                    ap_clk,
    input  logic                                    ap_rst_n,
    output logic                                    interrupt,

    // AXI4-Lite slave interface
    input  logic                                    s_axi_control_awvalid,
    output logic                                    s_axi_control_awready,
    input  logic [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_awaddr ,

    input  logic                                    s_axi_control_wvalid ,
    output logic                                    s_axi_control_wready ,
    input  logic [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_wdata  ,
    input  logic [C_S_AXI_CONTROL_DATA_WIDTH/8-1:0] s_axi_control_wstrb  ,

    input  logic                                    s_axi_control_arvalid,
    output logic                                    s_axi_control_arready,
    input  logic [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_araddr ,

    output logic                                    s_axi_control_rvalid ,
    input  logic                                    s_axi_control_rready ,
    output logic [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_rdata  ,
    output logic [2-1:0]                            s_axi_control_rresp  ,

    output logic                                    s_axi_control_bvalid ,
    input  logic                                    s_axi_control_bready ,
    output logic [2-1:0]                            s_axi_control_bresp  ,

    // PMOD
    output logic [7:0]                              pmod
);


    localparam int COUNT_WIDTH = 32;

    // --------------------------------------------------------------------------------
    // Logic Declarations
    // --------------------------------------------------------------------------------
    
    logic [COUNT_WIDTH-1:0] counter_q;
    logic axi_read_active;
    logic valid_read_req;
    logic [31:0] read_data;

    // --------------------------------------------------------------------------------
    // Counter
    // --------------------------------------------------------------------------------
    
    always_ff @(posedge ap_clk or negedge ap_rst_n)
        if (!ap_rst_n) counter_q <= '0;
        else counter_q <= counter_q + COUNT_WIDTH'(1);

    assign pmod = counter_q[24+:8];


    // --------------------------------------------------------------------------------
    // Register
    // --------------------------------------------------------------------------------
    // Provide a single read only register to keep things simple.  A read to address
    // 0x0 returns B00BCAFE, DEADBEEF otherwise.
    // --------------------------------------------------------------------------------
    

    assign valid_read_req = s_axi_control_arvalid && s_axi_control_arready;

    always_ff @(posedge ap_clk or negedge ap_rst_n) begin : axi_slave
        if (!ap_rst_n) begin
            axi_read_active       <= '0;
            s_axi_control_arready <= '1;
            read_data             <= '0;
            s_axi_control_bvalid  <= '0;
        end else begin
            
            case(axi_read_active)
                1'b0 : begin
                    s_axi_control_arready <= '1;
                    axi_read_active       <=  valid_read_req;
                    read_data             <=  |s_axi_control_araddr ? 32'hdeadbeef : 32'hb00bcafe;
                end
                1'b1 : begin
                    s_axi_control_arready <=  s_axi_control_rready;
                    axi_read_active       <= !s_axi_control_rready;
                end
            endcase

            /* Must return a write response even though we ignore all write data */
            s_axi_control_bvalid <= s_axi_control_wvalid;
        end
    end

    /* Always OKAY response */
    assign s_axi_control_bresp  = '0; 

    /* Each read request */
    assign s_axi_control_rvalid = axi_read_active;
    assign s_axi_control_rdata  = read_data;
    assign s_axi_control_rresp  = '0;

    /* Ignore all write requests */
    assign s_axi_control_awready = '1;
    assign s_axi_control_wready  = '1;

    /* Unused interrupt output */
    assign interrupt = '0;

endmodule

