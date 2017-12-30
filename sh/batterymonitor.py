#!/usr/bin/env python

# coded using http://candidtim.github.io/appindicator/2014/09/13/ubuntu-appindicator-step-by-step.html

import os
import gi
import signal

gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
gi.require_version('Notify', '0.7')

from gi.repository import Gtk as gtk
from gi.repository import AppIndicator3 as appindicator
from gi.repository import Notify as notify
from gi.repository import GLib as glib


APPINDICATOR_ID = 'batterymonitor'
BATTERY = "/sys/class/power_supply/BAT0/"
BATTERY_CAP = BATTERY + "capacity"
BATTERY_STAT = BATTERY + "status"

def main():
    indicator = appindicator.Indicator.new(APPINDICATOR_ID, 
       os.path.abspath('/usr/share/icons/Adwaita/24x24/devices/battery.png'),
       appindicator.IndicatorCategory.SYSTEM_SERVICES)
    indicator.set_status(appindicator.IndicatorStatus.ACTIVE)
    indicator.set_menu(build_menu())
    notify.init(APPINDICATOR_ID)
    glib.timeout_add(3*1000, battery_timer) # call every 5 mins
    gtk.main()

def battery_timer(*args):
    show(None)
    return True

def build_menu():
    menu = gtk.Menu()
    item_show = gtk.MenuItem(label='show')
    item_show.connect('activate', show)
    menu.append(item_show)
    item_quit = gtk.MenuItem('quit')
    item_quit.connect('activate', quit)
    menu.append(item_quit)
    menu.show_all()
    return menu

def show(menu_item):
    with open(BATTERY_STAT) as stat:
        stat_str = stat.read().strip()
   
    if stat_str.lower() != 'charging':
        with open(BATTERY_CAP) as cap:
            cap_str = cap.read().strip()
            message = "%s (%s)" % (cap_str, stat_str)
            notification = notify.Notification.new(
                                                  "<b>Battery Status:<br></b>",
                                                  message, None)
            if int(cap_str) <= 30:
                notification.set_urgency(2)

            notification.show()
        

def quit(menu_item):
    notify.uninit()
    gtk.main_quit()

if __name__ == "__main__":
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    main()
