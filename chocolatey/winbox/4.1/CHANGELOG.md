## WinBox - [Changelog](https://forum.mikrotik.com/t/winbox-v4-1-released/269878)

### What's new in 4.1 (2026-Apr-13 09:33):

* form: improve "address" field by allowing to select Interface and VRF fields (where supported);
* form: allow opening linked object or its parent table for certain fields (e.g., when adding an IP address and selecting an interface from the dropdown, it is possible to open either the interface table or the selected interface);
* form: add support for input field postfix;
* form: add support for min/max row count limit for multi fields;
* form: add support for monospace font in scripts;
* form: add support for new "note" attribute which shows documentation or hints on label hover;
* form: change style of multi field plus/minus buttons;
* form: fix "hyperlink" field type (IP/Routes Immediate Gateway);
* form: fix sorting for some fields;
* form: increase minimal width for combobox and multi-selection fields;
* mdi: fix resizing when window was moved to top or left side and then resized;
* mdi: move window resize mouse area 1px deeper within content;
* mdi: try to move whole window into workspace when (re)opening;
* table: change disabled row icon color;
* table: fix warnings printed in app output;
* table: make New button with dropdown expand full available height;
* table: send only disable/enable attribute when disabling/enabling row;
* table: try to fix Windows on ARM rendering issues;
* table: update some firewall table icons to stand out more;
* ui: fix Cancel button focus in file transfer progress dialog;
* ui: increase combobox popup's minimal width;
* ui: make checkbox/radio/tooltip background color darker in light mode;
* ui: make search result rows a little taller;
* ui: simplify error message with MAC connection when device is not responding;
* add new field type support used by future RouterOS version;
* change intermediary certificate for Windows executable signing;