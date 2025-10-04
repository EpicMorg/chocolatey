## WinBox - [Changelog](https://forum.mikrotik.com/viewtopic.php?t=101949)

### What's new in v3.0:
* added support for new internal WinBox protocol fields;
* do not reset user name & password when one of the routers is selected in neighbours list;

### What's new in v3.0rc17:

* discover older version RouterOS routers and SwOS switches as well;

### What's new in v3.0rc16:

* fixed problem where it was not possible to connect to router through RoMON if
Open in New Window was enabled;

### What's new in v3.0rc15:

* make "Install & Upgrade" button work again;
* fixed crash when typing Ctrl-D in empty terminal window;

### What's new in v3.0rc14:

* show properly advanced mode on start up;
* make console use whole terminal window width on reopen;

### What's new in v3.0rc13:

* allow to specify RoMON agent via command line;
* fixed window size when Winbox is opened first time;

### What's new in v3.0rc12:

* added "clear cache" command to Tools menu;

### What's new in v3.0rc11:

* fixed session saving;
* move cursor to password or login field when host is selected in address list
or in neighbours

### What's new in v3.0rc10:

* remember first window size;
* fixed crash when trying to connect to the router;
* fixed connecting by mac addresses on Windows with multiple network
cards (needs at least RouterOS v6.29 on the router as well);
* added back keyboard short-cuts for tables (INS for add, DEL for remove
and all other with Ctrl prefixes);
* added support for Shift+Ins, Ctrl+Ins, Shift+Del short-cuts in text entry fields;
* fixed crash when connecting to v5 routers;
* fixed problem where group column contents were not shown;

### What's new in v3.0rc9:

* added advanced mode;

### What's new in v3.0rc8:

* added RoMON support;
* show default values in CAPsMAN settings;
* fixed crash when reopening ping or profile window;

### What's new in v3.0rc6:

* allow to in-line comments per table bases as well;
* remember table filters in current sessions;
* remember Torch window column sorting order & visibility;
* by default hide all passwords;
* remember that session was <own> on reconnects;

### What's new in v3.0rc5:

* fixed problem where active session was not loaded immediately on connect;

### What's new in v3.0rc4:

* fixed problem were secure connections when opening in new window were not closed;
* fixed problem when in-line-comment added comment column
where no comments were allowed;
* added save session to Session menu;

### What's new in v3.0rc3:

* fixed problem where in-line-comments setting to affected only visible tabs;
* allow to move session file folder;
* allow to choose session file from any place;
* fixed embedded table size;

### What's new in v3.0rc2:

* allow to make object list windows smaller;
* support connecting to v5 routers with "Open In New Window";
* do not save last session password if address list is encrypted;
* fixed problem where "open in new window" didn't work;
* fixed crash on session save;
* fixed crash when opening ip web proxy access window;
* handle correctly sessions that have ':' in their names;

### What's new in v3.0rc1:

* made global setting for comment in-lining;
* added session management;
* added ability to connect to multiple routers at once;
* added ability to save address list in another place;
* added ability to encrypt address list file;
* fixed Dst. Address filter in ip routes;
* make Winbox work with TeamViewer;
* report connection & disconnect status in-place;

### What's new in v3.0beta3:

* make log table show last entries automatically;
* fixed problem were changing managed entries made them disappear;
* when sorting by groups in-line category headers as well;
* added "New Winbox" button;
* fixed crash when opening tools|profile;

### What's new in v3.0beta2:

* fixed problem where Winbox crashed if Wirless-fp package was installed on the router;
* fixed problem where Winbox crashed if Activate button was pressed in Stores menu;

### What's new in v3.0beta1:

* implemented self upgrade;
* added ability to open new session in new window;