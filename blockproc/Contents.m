% LTFAT - Block processing
%
%  Zdenek Prusa, 2013 - 2014.
%
%  Basic methods
%    BLOCK          - Setup a new block-stream
%    BLOCKDEVICES   - List available audio I/O devices
%    BLOCKREAD      - Read samples from file/device
%    BLOCKPLAY      - Play block (sound output)
%    BLOCKPANEL     - Block-stream control GUI
%    BLOCKPANELGET  - Obtain parameter(s) from GUI
%    BLOCKDONE      - Closes block-stream and frees resources
%    BLOCKWRITE     - Appends data to a wav file
%
%  Block-adapted transforms
%    BLOCKFRAMEACCEL     - Prepare a frame for a block-stream processing
%    BLOCKFRAMEPAIRACCEL - Prepare a pair of frames for a block-stream processing
%    BLOCKANA            - Block analysis
%    BLOCKSYN            - Block synthesis
%
%  Running visualisation
%    BLOCKFIGURE   - Initialize figure for redrawing
%    BLOCKPLOT     - Append coefficients to the running plot
%
%  Helper functions
%    BLOCK_FWT      - |fwt| processing
%    BLOCK_IFWT     - |ifwt| processing
%
%  For help, bug reports, suggestions etc. please send email to
%  ltfat-help@lists.sourceforge.net
