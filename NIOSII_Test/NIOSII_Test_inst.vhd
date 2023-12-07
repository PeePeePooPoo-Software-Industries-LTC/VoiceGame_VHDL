	component NIOSII_Test is
		port (
			audio_interface_ADCDAT  : in    std_logic                     := 'X';             -- ADCDAT
			audio_interface_ADCLRCK : in    std_logic                     := 'X';             -- ADCLRCK
			audio_interface_BCLK    : in    std_logic                     := 'X';             -- BCLK
			vga_CLK                 : out   std_logic;                                        -- CLK
			vga_HS                  : out   std_logic;                                        -- HS
			vga_VS                  : out   std_logic;                                        -- VS
			vga_BLANK               : out   std_logic;                                        -- BLANK
			vga_SYNC                : out   std_logic;                                        -- SYNC
			vga_R                   : out   std_logic_vector(7 downto 0);                     -- R
			vga_G                   : out   std_logic_vector(7 downto 0);                     -- G
			vga_B                   : out   std_logic_vector(7 downto 0);                     -- B
			sram_DQ                 : inout std_logic_vector(15 downto 0) := (others => 'X'); -- DQ
			sram_ADDR               : out   std_logic_vector(19 downto 0);                    -- ADDR
			sram_LB_N               : out   std_logic;                                        -- LB_N
			sram_UB_N               : out   std_logic;                                        -- UB_N
			sram_CE_N               : out   std_logic;                                        -- CE_N
			sram_OE_N               : out   std_logic;                                        -- OE_N
			sram_WE_N               : out   std_logic;                                        -- WE_N
			clk_clk                 : in    std_logic                     := 'X';             -- clk
			reset_reset_n           : in    std_logic                     := 'X'              -- reset_n
		);
	end component NIOSII_Test;

	u0 : component NIOSII_Test
		port map (
			audio_interface_ADCDAT  => CONNECTED_TO_audio_interface_ADCDAT,  -- audio_interface.ADCDAT
			audio_interface_ADCLRCK => CONNECTED_TO_audio_interface_ADCLRCK, --                .ADCLRCK
			audio_interface_BCLK    => CONNECTED_TO_audio_interface_BCLK,    --                .BCLK
			vga_CLK                 => CONNECTED_TO_vga_CLK,                 --             vga.CLK
			vga_HS                  => CONNECTED_TO_vga_HS,                  --                .HS
			vga_VS                  => CONNECTED_TO_vga_VS,                  --                .VS
			vga_BLANK               => CONNECTED_TO_vga_BLANK,               --                .BLANK
			vga_SYNC                => CONNECTED_TO_vga_SYNC,                --                .SYNC
			vga_R                   => CONNECTED_TO_vga_R,                   --                .R
			vga_G                   => CONNECTED_TO_vga_G,                   --                .G
			vga_B                   => CONNECTED_TO_vga_B,                   --                .B
			sram_DQ                 => CONNECTED_TO_sram_DQ,                 --            sram.DQ
			sram_ADDR               => CONNECTED_TO_sram_ADDR,               --                .ADDR
			sram_LB_N               => CONNECTED_TO_sram_LB_N,               --                .LB_N
			sram_UB_N               => CONNECTED_TO_sram_UB_N,               --                .UB_N
			sram_CE_N               => CONNECTED_TO_sram_CE_N,               --                .CE_N
			sram_OE_N               => CONNECTED_TO_sram_OE_N,               --                .OE_N
			sram_WE_N               => CONNECTED_TO_sram_WE_N,               --                .WE_N
			clk_clk                 => CONNECTED_TO_clk_clk,                 --             clk.clk
			reset_reset_n           => CONNECTED_TO_reset_reset_n            --           reset.reset_n
		);

