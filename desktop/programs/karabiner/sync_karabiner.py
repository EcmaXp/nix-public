#!/usr/bin/env nix-shell
#! nix-shell -i python3 -p python3 python3Packages.pyyaml

import json
import re
import sys
import time
import traceback
from contextlib import suppress
from copy import deepcopy
from pathlib import Path

import yaml

KARABINER_CONFIG_PATH = Path("~/.config/karabiner/karabiner.json")
KARABINER_RULES_PATH = Path("karabiner.yaml")


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

KEY_TYPES = set(KEY_CODES.keys())

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
}

MODIFIERS = {
    "ctrl": ["left_control"],
    "shift": ["left_shift"],
    "alt": ["left_alt"],
    "cmd": ["left_command"],
    "rctrl": ["right_control"],
    "rshift": ["right_shift"],
    "ralt": ["right_alt"],
    "rcmd": ["right_command"],
    "fn": ["fn"],
} | {key: [key] for key in {"any", "fn"}}

COMPACT_KEYS = {
    "hyper": "rcmd-rctrl-ralt-rshift",
}

PACKED_KEYS = {
    "left_right": ("left", "right"),
    "up_down": ("up", "down"),
    "arrows": ("left", "right", "up", "down"),
    "page_up_down": ("page_up", "page_down"),
    "home_end": ("home", "end"),
}

KEY = r"[a-zA-Z0-9_]+"
RE_KEY = re.compile(rf"(?P<key>{KEY})").pattern
RE_OPTIONAL_MODIFIERS = re.compile(rf"(?P<optional>({KEY}\*)*)").pattern
RE_MANDATORY_MODIFIERS = re.compile(rf"(?P<mandatory>({KEY}\-)*)").pattern
RE_MODIFIERS = re.compile(rf"(?P<modifiers>({KEY}\-)*)").pattern

COMBINATION_CFG_KEYS = KEY_TYPES | {"modifiers"}
FROM_KEYS = {"from"}
TO_KEYS = {"to", "to_if_alone", "to_if_held_down"}
LIST_KEYS = TO_KEYS | {"conditions"}
TO_DELAY_KEY = "to_delayed_action"
TO_DELAY_KEYS = {"to_if_invoked", "to_if_canceled"}
ANY_KEYS = FROM_KEYS | TO_KEYS | TO_DELAY_KEYS


def parse_rules(rules: list[dict]):
    for rule in rules:
        parse_rule(rule)


def parse_applications(
    conditions: list[str | dict] | str | None, applications: list[str] | str | None
) -> list[str | dict] | str | None:
    if not applications:
        return conditions
    elif isinstance(applications, str):
        app_conditions = [parse_condition(f"app is {applications}")]
    elif isinstance(applications, list):
        app_conditions = [parse_condition(f"app is {app}") for app in applications]
    else:
        raise NotImplementedError(applications)

    if not conditions:
        return app_conditions
    elif isinstance(conditions, str):
        return [conditions, *app_conditions]
    elif isinstance(conditions, list):
        return [*conditions, *app_conditions]
    else:
        raise NotImplementedError(conditions)


def parse_rule(rule: dict):
    conditions = parse_applications(
        rule.pop("conditions", None),
        rule.pop("applications", None),
    )

    manipulators = []
    for manipulator in rule["manipulators"]:
        if conditions:
            manipulator["conditions"] = conditions

        for unrolled_manipulator in unroll_manipulators(manipulator):
            parse_manipulator(unrolled_manipulator)
            manipulators.append(unrolled_manipulator)

    rule["manipulators"] = manipulators


def unroll_manipulators(manipulator: dict) -> list[dict]:
    result = []
    conditions = manipulator.get("conditions", None)
    if not (manipulator.keys() & ANY_KEYS):
        for key, value in manipulator.items():
            if key == "conditions":
                continue

            result += unroll_manipulators(
                {
                    "from": key,
                    "to": value,
                }
                | ({"conditions": conditions} if conditions else {})
            )
        return result

    serialized_manipulator = json.dumps(manipulator)

    for packed_key, unpacked_keys in PACKED_KEYS.items():
        if packed_key in serialized_manipulator:
            for unpacked_key in unpacked_keys:
                result.append(
                    json.loads(serialized_manipulator.replace(packed_key, unpacked_key))
                )

            break
    else:
        result.append(manipulator)

    return result


def parse_manipulator(manipulator: dict):
    for key, value in manipulator.items():
        if key in LIST_KEYS and not isinstance(value, list):
            manipulator[key] = [value]

    if not manipulator.get("type"):
        manipulator["type"] = "basic"

    conditions = parse_applications(
        manipulator.pop("conditions", None),
        manipulator.pop("applications", None),
    )

    if conditions:
        parse_conditions(conditions)
        manipulator["conditions"] = conditions

    for from_ in FROM_KEYS:
        if from_ in manipulator:
            manipulator[from_] = parse_from_key(manipulator[from_])

    for to in TO_KEYS:
        if to in manipulator:
            for i, to_key in enumerate(manipulator[to]):
                with suppress(NotImplementedError):
                    manipulator[to][i] = parse_to_key(to_key)

    if TO_DELAY_KEY in manipulator:
        for to in TO_DELAY_KEYS:
            if to in manipulator[TO_DELAY_KEY]:
                for i, to_key in enumerate(manipulator[TO_DELAY_KEY][to]):
                    manipulator[TO_DELAY_KEY][to][i] = parse_to_key(to_key)


def parse_conditions(conditions: list[dict] | dict | str):
    if isinstance(conditions, list):
        for pos, condition in enumerate(conditions):
            conditions[pos] = parse_condition(condition)

        return conditions[0] if len(conditions) == 1 else conditions
    elif isinstance(conditions, (dict, str)):
        return [parse_condition(conditions)]


def parse_condition(condition: dict | str) -> dict | str:
    if isinstance(condition, str):
        if condition.startswith("app is "):
            condition = condition.removeprefix("app is ")
            description, bundle_identifiers = condition.split("(")
            bundle_identifiers = list(
                map(str.strip, bundle_identifiers.removesuffix(")").split(";"))
            )

            return {
                "type": "frontmost_application_if",
                "description": description,
                "bundle_identifiers": bundle_identifiers,
            }
        elif "==" in condition:
            name, value = map(str.strip, condition.split("=="))
            return {
                "type": "variable_if",
                "name": name,
                "value": json.loads(value),
            }
        elif "!=" in condition:
            name, value = map(str.strip, condition.split("!="))
            return {
                "type": "variable_unless",
                "name": name,
                "value": json.loads(value),
            }
        else:
            raise NotImplementedError(condition)
    else:
        return condition


def parse_complex_keys(combination_keys, parse_func):
    if isinstance(combination_keys, dict):
        return {
            **parse_func(combination_keys["keys"]),
            **{k: v for k, v in combination_keys.items() if k != "keys"},
        }


def parse_combination_keys(combination_keys: str) -> str:
    for key, seq in COMPACT_KEYS.items():
        combination_keys = combination_keys.replace(key, seq)

    return combination_keys


def parse_from_key(combination_keys):
    if combination_cfg := parse_complex_keys(combination_keys, parse_from_key):
        return combination_cfg

    combination_keys = parse_combination_keys(combination_keys)
    m = re.match(
        rf"^{RE_OPTIONAL_MODIFIERS}{RE_MANDATORY_MODIFIERS}{RE_KEY}$",
        combination_keys,
    )

    key = parse_key(m["key"])
    combination = {KEY_TO_TYPE[key]: key}

    modifiers = {}
    if optional_modifiers := m["optional"]:
        modifiers["optional"] = parse_modifiers(optional_modifiers.split("*"))
    if mandatory_modifiers := m["mandatory"]:
        modifiers["mandatory"] = parse_modifiers(mandatory_modifiers.split("-"))

    if modifiers:
        combination["modifiers"] = modifiers

    return combination


def parse_to_key(combination_keys):
    if "shell_command" in combination_keys:
        raise NotImplementedError

    if combination_cfg := parse_complex_keys(combination_keys, parse_to_key):
        return combination_cfg

    if "=" in combination_keys:
        name, value = map(str.strip, combination_keys.split("="))
        return {"set_variable": {"name": name, "value": json.loads(value)}}

    combination_keys = parse_combination_keys(combination_keys)
    m = re.match(rf"^{RE_MODIFIERS}{RE_KEY}$", combination_keys)
    key = parse_key(m["key"])

    combination = {KEY_TO_TYPE[key]: key}

    modifiers = parse_modifiers(m["modifiers"].split("-"))
    if modifiers:
        combination["modifiers"] = modifiers

    return combination


def parse_key(key: str) -> str:
    return KEY_ALIAS.get(key, key)


def parse_modifiers(modifiers: list[str] | None) -> list[str]:
    result = []
    for k in modifiers:
        if k:
            for modifier in MODIFIERS[k]:
                result.append(modifier)

    return result


def dump_rules(rules, f):
    for pos, rule in enumerate(rules):
        if pos:
            f.write("\n")

        yaml.safe_dump([rule], f, sort_keys=True)


def load_rules_from_yaml():
    with KARABINER_RULES_PATH.open("r") as f:
        return yaml.safe_load(f)


def save_rules_to_config(rules, *, dump: bool = True):
    with KARABINER_CONFIG_PATH.expanduser().open("r") as f:
        config = json.load(f)

    rules = deepcopy(rules)
    parse_rules(rules)

    if dump:
        dump_rules(rules, sys.stdout)

    config["profiles"][0]["complex_modifications"]["rules"] = rules
    with KARABINER_CONFIG_PATH.expanduser().open("w") as f:
        json.dump(config, f, indent=2, sort_keys=False)

    return rules


def keep(func, obj):
    obj = deepcopy(obj)
    func(obj)
    return obj


def sync_rules():
    rules = load_rules_from_yaml()
    dump_rules(rules, sys.stdout)
    print()

    last_modified = None
    while True:
        if KARABINER_RULES_PATH.stat().st_mtime != last_modified:
            last_modified = KARABINER_RULES_PATH.stat().st_mtime

            try:
                rules = load_rules_from_yaml()
                save_rules_to_config(rules, dump=False)
            except Exception:
                traceback.print_exc()

            print("Updated karabiner.json", last_modified)

        time.sleep(0.1)


def main():
    rules = load_rules_from_yaml()
    save_rules_to_config(rules, dump=False)
    sync_rules()


if __name__ == "__main__":
    main()
