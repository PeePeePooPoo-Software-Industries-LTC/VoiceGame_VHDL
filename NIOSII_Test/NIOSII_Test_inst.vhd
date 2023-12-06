	component NIOSII_Test is
		port (
			audio_interface_ADCDAT  : in  std_logic                    := 'X';             -- ADCDAT
			audio_interface_ADCLRCK : in  std_logic                    := 'X';             -- ADCLRCK
			audio_interface_BCLK    : in  std_logic                    := 'X';             -- BCLK
			audio_interface_DACDAT  : out std_logic;                                       -- DACDAT
			audio_interface_DACLRCK : in  std_logic                    := 'X';             -- DACLRCK
			clk_clk                 : in  std_logic                    := 'X';             -- clk
			keys_export             : in  std_logic_vector(2 downto 0) := (others => 'X'); -- export
			ledgs_export            : out std_logic_vector(7 downto 0);                    -- export
			reset_reset_n           : in  std_logic                    := 'X';             -- reset_n
			vga_CLK                 : out std_logic;                                       -- CLK
			vga_HS                  : out std_logic;                                       -- HS
			vga_VS                  : out std_logic;                                       -- VS
			vga_BLANK               : out std_logic;                                       -- BLANK
			vga_SYNC                : out std_logic;                                       -- SYNC
			vga_R                   : out std_logic_vector(7 downto 0);                    -- R
			vga_G                   : out std_logic_vector(7 downto 0);                    -- G
			vga_B                   : out std_logic_vector(7 downto 0)                     -- B
		);
	end component NIOSII_Test;

	u0 : component NIOSII_Test
		port map (
			audio_interface_ADCDAT  => CONNECTED_TO_audio_interface_ADCDAT,  -- audio_interface.ADCDAT
			audio_interface_ADCLRCK => CONNECTED_TO_audio_interface_ADCLRCK, --                .ADCLRCK
			audio_interface_BCLK    => CONNECTED_TO_audio_interface_BCLK,    --                .BCLK
			audio_interface_DACDAT  => CONNECTED_TO_audio_interface_DACDAT,  --                .DACDAT
			audio_interface_DACLRCK => CONNECTED_TO_audio_interface_DACLRCK, --                .DACLRCK
			clk_clk                 => CONNECTED_TO_clk_clk,                 --             clk.clk
			keys_export             => CONNECTED_TO_keys_export,             --            keys.export
			ledgs_export            => CONNECTED_TO_ledgs_export,            --           ledgs.export
			reset_reset_n           => CONNECTED_TO_reset_reset_n,           --           reset.reset_n
			vga_CLK                 => CONNECTED_TO_vga_CLK,                 --             vga.CLK
			vga_HS                  => CONNECTED_TO_vga_HS,                  --                .HS
			vga_VS                  => CONNECTED_TO_vga_VS,                  --                .VS
			vga_BLANK               => CONNECTED_TO_vga_BLANK,               --                .BLANK
			vga_SYNC                => CONNECTED_TO_vga_SYNC,                --                .SYNC
			vga_R                   => CONNECTED_TO_vga_R,                   --                .R
			vga_G                   => CONNECTED_TO_vga_G,                   --                .G
			vga_B                   => CONNECTED_TO_vga_B                    --                .B
		);

