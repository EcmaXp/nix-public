from ...keyboard.types import Shortcut


def key_range(start, end):
    return [chr(ch) for ch in range(ord(start), ord(end) + 1)]


KEY_CODES = {
    "key_code": {
        "vk_none",
        "left_option",
        "left_command",
        "right_option",
        "right_command",
        "japanese_eisuu",
        "japanese_kana",
        "japanese_pc_nfer",
        "japanese_pc_xfer",
        "japanese_pc_katakana",
        *key_range("a", "z"),
        *key_range("0", "9"),
        "return_or_enter",
        "escape",
        "delete_or_backspace",
        "tab",
        "spacebar",
        "hyphen",
        "equal_sign",
        "open_bracket",
        "close_bracket",
        "backslash",
        "non_us_pound",
        "semicolon",
        "quote",
        "grave_accent_and_tilde",
        "comma",
        "period",
        "slash",
        "caps_lock",
        *[f"f{num}" for num in range(1, 12 + 1)],
        "print_screen",
        "scroll_lock",
        "pause",
        "insert",
        "home",
        "page_up",
        "delete_forward",
        "end",
        "page_down",
        "right_arrow",
        "left_arrow",
        "down_arrow",
        "up_arrow",
        "keypad_num_lock",
        "keypad_slash",
        "keypad_asterisk",
        "keypad_hyphen",
        "keypad_plus",
        "keypad_enter",
        *[f"keypad_{num}" for num in range(0, 9 + 1)],
        "keypad_period",
        "non_us_backslash",
        "application",
        "power",
        "keypad_equal_sign",
        *[f"f{num}" for num in range(13, 24 + 1)],
        "execute",
        "help",
        "menu",
        "select",
        "stop",
        "again",
        "undo",
        "cut",
        "copy",
        "paste",
        "find",
        "mute",
        "volume_down",
        "volume_up",
        "locking_caps_lock",
        "locking_num_lock",
        "locking_scroll_lock",
        "keypad_comma",
        "keypad_equal_sign_as400",
        *[f"international_{num}" for num in range(1, 9 + 1)],
        *[f"lang_{num}" for num in range(1, 9 + 1)],
        "alternate_erase",
        "sys_req_or_attention",
        "cancel",
        "clear",
        "prior",
        "return",
        "separator",
        "out",
        "oper",
        "clear_or_again",
        "cr_sel_or_props",
        "ex_sel",
        "left_control",
        "left_shift",
        "left_alt",
        "left_gui",
        "right_control",
        "right_shift",
        "right_alt",
        "right_gui",
    },
    "consumer_key_code": {
        "dictation",
        "power",
        "menu",
        "menu_pick",
        "menu_up",
        "menu_down",
        "menu_left",
        "menu_right",
        "menu_escape",
        "menu_value_increase",
        "menu_value_decrease",
        "data_on_screen",
        "closed_caption",
        "closed_caption_select",
        "vcr_or_tv",
        "broadcast_mode",
        "snapshot",
        "still",
        "picture_in_picture_toggle",
        "picture_in_picture_swap",
        "red_menu_button",
        "green_menu_button",
        "blue_menu_button",
        "yellow_menu_button",
        "aspect",
        "three_dimensional_mode_select",
        "display_brightness_increment",
        "display_brightness_decrement",
        "fast_forward",
        "rewind",
        "scan_next_track",
        "scan_previous_track",
        "eject",
        "play_or_pause",
        "voice_command",
        "mute",
        "volume_increment",
        "volume_decrement",
        "al_consumer_control_configuration",
        "al_word_processor",
        "al_text_editor",
        "al_spreadsheet",
        "al_graphics_editor",
        "al_presentation_app",
        "al_database_app",
        "al_email_reader",
        "al_newsreader",
        "al_voicemail",
        "al_contacts_or_address_book",
        "al_Calendar_Or_Schedule",
        "al_task_or_project_manager",
        "al_log_or_journal_or_timecard",
        "al_checkbook_or_finance",
        "al_calculator",
        "al_a_or_v_capture_or_playback",
        "al_local_machine_browser",
        "al_lan_or_wan_browser",
        "al_internet_browser",
        "al_remote_networking_or_isp_connect",
        "al_network_conference",
        "al_network_chat",
        "al_telephony_or_dialer",
        "al_logon",
        "al_logoff",
        "al_logon_or_logoff",
        "al_terminal_lock_or_screensaver",
        "al_control_panel",
        "al_command_line_processor_or_run",
        "al_process_or_task_manager",
        "al_select_task_or_application",
        "al_next_task_or_application",
        "al_previous_task_or_application",
        "al_preemptive_halt_task_or_application",
        "al_integrated_help_center",
        "al_documents",
        "al_thesaurus",
        "al_dictionary",
        "al_desktop",
        "al_spell_check",
        "al_grammer_check",
        "al_wireless_status",
        "al_keyboard_layout",
        "al_virus_protection",
        "al_encryption",
        "al_screen_saver",
        "al_alarms",
        "al_clock",
        "al_file_browser",
        "al_power_status",
        "al_image_browser",
        "al_audio_browser",
        "al_movie_browser",
        "al_digital_rights_manager",
        "al_digital_wallet",
        "al_instant_messaging",
        "al_oem_feature_browser",
        "al_oem_help",
        "al_online_community",
        "al_entertainment_content_browser",
        "al_online_shopping_browswer",
        "al_smart_card_information_or_help",
        "al_market_monitor_or_finance_browser",
        "al_customized_corporate_news_browser",
        "al_online_activity_browswer",
        "al_research_or_search_browswer",
        "al_audio_player",
        "al_message_status",
        "al_contact_sync",
        "al_navigation",
        "al_contextaware_desktop_assistant",
        "ac_home",
        "ac_back",
        "ac_forward",
        "ac_refresh",
        "ac_bookmarks",
        "fastforward",
    },
    "apple_vendor_keyboard_key_code": {
        "mission_control",
        "spotlight",
        "dashboard",
        "function",
        "launchpad",
        "expose_all",
        "expose_desktop",
        "brightness_up",
        "brightness_down",
        "language",
    },
    "apple_vendor_top_case_key_code": {
        "apple_top_case_display_brightness_decrement",
        "apple_top_case_display_brightness_increment",
        "keyboard_fn",
        "illumination_decrement",
        "illumination_increment",
    },
    "pointing_button": {
        *[f"button{num}" for num in range(1, 32 + 1)],
    },
}

KEY_TO_TYPE = {v: k for k, vs in KEY_CODES.items() for v in vs}

KEY_ALIAS = {
    "ctrl": "left_control",
    "shift": "left_shift",
    "alt": "left_alt",
    "cmd": "left_command",
    "rctrl": "right_control",
    "rshift": "right_shift",
    "ralt": "right_alt",
    "rcmd": "right_command",
    "left": "left_arrow",
    "right": "right_arrow",
    "up": "up_arrow",
    "down": "down_arrow",
    "fn": "keyboard_fn",
    "enter": "return_or_enter",
    "space": "spacebar",
    "none": "vk_none",
}

MODIFIERS = {
    "ctrl": "left_control",
    "shift": "left_shift",
    "alt": "left_alt",
    "cmd": "left_command",
    "rctrl": "right_control",
    "rshift": "right_shift",
    "ralt": "right_alt",
    "rcmd": "right_command",
    "fn": "fn",
    "any": "any",
    "hyper": "hyper",
}

PACKED_KEYS = {
    "left_right": ("left", "right"),
    "up_down": ("up", "down"),
    "arrows": ("left", "right", "up", "down"),
    "page_up_down": ("page_up", "page_down"),
    "home_end": ("home", "end"),
    "alphabets": "".join(map(chr, range(ord("a"), ord("z") + 1))),
    "alphanums": "".join(map(chr, range(ord("a"), ord("z") + 1))) + "0123456789",
    "numbers": "0123456789",
}


def normalize_shortcut(shortcut: Shortcut) -> Shortcut:
    if shortcut.key == "hyper":
        shortcut = Shortcut(
            optional_modifiers=shortcut.optional_modifiers,
            mandatory_modifiers=(
                shortcut.mandatory_modifiers + ("rcmd", "rctrl", "ralt")
            ),
            key="rshift",
        )

    shortcut = shortcut.normalize()
    return Shortcut(
        optional_modifiers=convert_modifiers(shortcut.optional_modifiers),
        mandatory_modifiers=convert_modifiers(shortcut.mandatory_modifiers),
        key=shortcut.key,
    )


def convert_key(key: str) -> dict:
    if key.startswith("@any "):
        return {"any": key.removeprefix("@any ")}

    key = KEY_ALIAS.get(key, key)
    return {KEY_TO_TYPE[key]: key}


def convert_modifiers(modifiers: tuple[str, ...]) -> tuple[str, ...]:
    return tuple(MODIFIERS[modifier] for modifier in modifiers)
