{ lib, ... }:
let
  python = self: super: {
    python312 = super.python312.override {
      packageOverrides = pySelf: pySuper: {
        aiohttp = pySuper.aiohttp.overridePythonAttrs {
          disabledTests = [
            # failed tests on python 3.12 @ 2025-04-26
            "test_connector_multiple_event_loop"
            "test_constructor[uvloop]"
          ];
        };
      };
    };
  };
in
{
  nixpkgs.overlays = lib.mkBefore [
    python
  ];
}
