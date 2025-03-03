{ pkgs-unstable, ... }:
let
  pyp = (
    self: super: {
      pyp =
        (super.pyp.override {
          python3 = pkgs-unstable.python313;
        }).overridePythonAttrs
          {
            dependencies = with pkgs-unstable.python313Packages; [
              requests
            ];

            disabledTests = [
              # failed tests on python 3.13 @ 2024-11-02
              "test_user_error"
              "test_tracebacks"
            ];
          };
    }
  );
in
{
  nixpkgs.overlays = [
    pyp
  ];
}
