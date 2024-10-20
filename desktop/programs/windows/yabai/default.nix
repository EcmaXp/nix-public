{ ... }: {
  services.yabai = {
    enable = false;

    config = {
      external_bar = "off:40:0";
      menubar_opacity = 1.0;
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      display_arrangement_order = "default";
      window_origin_display = "default";
      window_placement = "second_child";
      window_zoom_persist = "on";
      insert_feedback_color = "0xff5fd75f";
      split_ratio = 0.50;
      split_type = "auto";
      auto_balance = "on";
      top_padding = 4;
      bottom_padding = 4;
      left_padding = 4;
      right_padding = 4;
      window_gap = 4;
      layout = "bsp";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };

    extraConfig = ''
      yabai -m rule --add app="^Raycast$" manage=off
      yabai -m rule --add app="^시스템 설정$" manage=off
      yabai -m rule --add app="^미리보기$" manage=off
      yabai -m rule --add app="^Finder$" manage=off
    '';
  };
}
