	component NIOSII_Test is
		port (
			audio_interface_ADCDAT  : in    std_logic                     := 'X';             -- ADCDAT
			audio_interface_ADCLRCK : in    std_logic                     := 'X';             -- ADCLRCK
			audio_interface_BCLK    : in    std_logic                     := 'X';             -- BCLK
			clk_clk                 : in    std_logic                     := 'X';             -- clk
			reset_reset_n           : in    std_logic                     := 'X';             -- reset_n
			vga_CLK                 : out   std_logic;                                        -- CLK
			vga_HS                  : out   std_logic;                                        -- HS
			vga_VS                  : out   std_logic;                                        -- VS
			vga_BLANK               : out   std_logic;                                        -- BLANK
			vga_SYNC                : out   std_logic;                                        -- SYNC
			vga_R                   : out   std_logic_vector(7 downto 0);                     -- R
			vga_G                   : out   std_logic_vector(7 downto 0);                     -- G
			vga_B                   : out   std_logic_vector(7 downto 0);                     -- B
			sdram_interface_addr    : out   std_logic_vector(11 downto 0);                    -- addr
			sdram_interface_ba      : out   std_logic;                                        -- ba
			sdram_interface_cas_n   : out   std_logic;                                        -- cas_n
			sdram_interface_cke     : out   std_logic;                                        -- cke
			sdram_interface_cs_n    : out   std_logic;                                        -- cs_n
			sdram_interface_dq      : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			sdram_interface_dqm     : out   std_logic_vector(3 downto 0);                     -- dqm
			sdram_interface_ras_n   : out   std_logic;                                        -- ras_n
			sdram_interface_we_n    : out   std_logic                                         -- we_n
		);
	end component NIOSII_Test;

	u0 : component NIOSII_Test
		port map (
			audio_interface_ADCDAT  => CONNECTED_TO_audio_interface_ADCDAT,  -- audio_interface.ADCDAT
			audio_interface_ADCLRCK => CONNECTED_TO_audio_interface_ADCLRCK, --                .ADCLRCK
			audio_interface_BCLK    => CONNECTED_TO_audio_interface_BCLK,    --                .BCLK
			clk_clk                 => CONNECTED_TO_clk_clk,                 --             clk.clk
			reset_reset_n           => CONNECTED_TO_reset_reset_n,           --           reset.reset_n
			vga_CLK                 => CONNECTED_TO_vga_CLK,                 --             vga.CLK
			vga_HS                  => CONNECTED_TO_vga_HS,                  --                .HS
			vga_VS                  => CONNECTED_TO_vga_VS,                  --                .VS
			vga_BLANK               => CONNECTED_TO_vga_BLANK,               --                .BLANK
			vga_SYNC                => CONNECTED_TO_vga_SYNC,                --                .SYNC
			vga_R                   => CONNECTED_TO_vga_R,                   --                .R
			vga_G                   => CONNECTED_TO_vga_G,                   --                .G
			vga_B                   => CONNECTED_TO_vga_B,                   --                .B
			sdram_interface_addr    => CONNECTED_TO_sdram_interface_addr,    -- sdram_interface.addr
			sdram_interface_ba      => CONNECTED_TO_sdram_interface_ba,      --                .ba
			sdram_interface_cas_n   => CONNECTED_TO_sdram_interface_cas_n,   --                .cas_n
			sdram_interface_cke     => CONNECTED_TO_sdram_interface_cke,     --                .cke
			sdram_interface_cs_n    => CONNECTED_TO_sdram_interface_cs_n,    --                .cs_n
			sdram_interface_dq      => CONNECTED_TO_sdram_interface_dq,      --                .dq
			sdram_interface_dqm     => CONNECTED_TO_sdram_interface_dqm,     --                .dqm
			sdram_interface_ras_n   => CONNECTED_TO_sdram_interface_ras_n,   --                .ras_n
			sdram_interface_we_n    => CONNECTED_TO_sdram_interface_we_n     --                .we_n
		);

