## WinBox - [Changelog](https://forum.mikrotik.com/t/winbox-4-4-released/273111)

### What's new in 4.4 (2026-09-14)::

* app: add ROS gui file caching support;
    - downloaded to standard OS cache directory;
    - cached for 30 days;
    - rechecked on startup if 24h passed;
* app: remember previously used file selector dialog path;
    - for upload/download/addresses separate context/path;
* combobox: fix refreshing items with filtered lists;
* fix crash when disabling interface and then disconnecting;
* form,table: fix some advanced lookup fields, when there is no value;
* form: add support to reset configuration for some objects;
* form: fix crash when fast pressing Start/Stop in some action panels;
* form: improve inherited value ux to not show set value if field is closed;
* form: improve qr code rendering;
* form: prevent calling multiple parallel add/set commands in same form;
* graphs: show y labels and values in same scale;
* login,neighbors: use mac address if IP not valid when clicking any cell;
* table: improve performance when many rows selected and changes are happening;
    - e.g. select all rows and remove;.
* ui: add Clear cache button in settings panel;
* ui: add confirmation dialog when removing table items (with opt-out feature);
    - except Login Saved table always ask for confirmation;
* ui: add downloading gui files progress information;
* ui: add option to auto follow system theme (auto/dark/light);
* ui: add option to configure terminal scrollback buffer size;
* ui: add spacers in Shortcuts info popup panel;
* ui: add support for opening multiple internal instances for table windows without tabs;
    - e.g. Log,Radius;
* ui: allow opening relevant sections when clicking on Resources bottom panel;
* ui: change color of .npk icons in Files menu to differ from directories;
* ui: left menu: rework submenu closing logic for better UX;
    - also set minimal width of submenu;
* ui: login panel change Remember -> remember (lower case) for consistency;
* ui: make default scrollbar width/height a few px larger;
* ui: make sysnote popup display in monospace font;
* ui: optimize event list performance;
* ui: pause event list message auto removal while list is mouse hovered;
* ui: shortcuts panel: add info about Shift+Click for multi column sort and multi tab open;
* ui: store OS window position in workspace files and restore when connecting with "open in new";
* ui: table: add shortcut tooltip info for Find widget and make it a little wider;
* winbox-api: add support for new field types for future use;
* winbox-api: fix some advanced fields used in ros6 routing;