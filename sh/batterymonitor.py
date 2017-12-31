#!/usr/bin/env python

# coded using http://candidtim.github.io/appindicator/2014/09/13/ubuntu-appindicator-step-by-step.html

import os
import gi
import signal
from datetime import datetime, timedelta

gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
gi.require_version('Notify', '0.7')

from gi.repository import Gtk as gtk
from gi.repository import AppIndicator3 as appindicator
from gi.repository import Notify as notify
from gi.repository import GLib as glib

APPINDICATOR_ID = 'batterymonitor'
ICON_PATH = '/usr/share/icons/Adwaita/24x24/devices/battery.png'

class BatteryMonitor:

    """Battery monitoring class"""

    BATTERY = "/sys/class/power_supply/BAT0/"
    BATTERY_CAP = BATTERY + "capacity"
    BATTERY_STAT = BATTERY + "status"
    UPDATE_INTERVAL = 300 # seconds
    RUN_INTERVAL = 10 # seconds
    UPDATE_PERCENT = 5
    LOW_THRESHOLD = 30

    def __init__(self):
        self.capacity = int(self.get_capacity())
        self.last_update = datetime.now()
        glib.timeout_add_seconds(self.RUN_INTERVAL, self)

    def __call__(self, menu_item=None):
        stat_str = self.get_status()

        if stat_str == 'discharging':
            self.update(stat_str)

        return True

    def update(self, stat_str):
        cap_str = self.get_capacity()
        now = datetime.now()
        capacity = int(cap_str)
        if (now > self.last_update + timedelta(seconds=self.UPDATE_INTERVAL)
            or self.capacity - capacity > self.UPDATE_PERCENT):
            # time or capacity check -> then show the status
            self.show(None, stat_str, cap_str)
            self.last_update = now
            self.capacity = capacity

    def show(self, menu_item=None, stat_str=None, cap_str=None):
        if stat_str is None:
            stat_str = self.get_status()

        if cap_str is None:
            cap_str = self.get_capacity()
            
        message = "%s (%s)" % (cap_str, stat_str)
        notification = notify.Notification.new("<b>Battery Status:<br></b>",
                                               message, None)
        if int(cap_str) <= self.LOW_THRESHOLD:
            notification.set_urgency(2)

        notification.show()

    def get_status(self):
        with open(self.BATTERY_STAT) as stat:
            stat_str = stat.read().strip()

        return stat_str.lower()

    def get_capacity(self):
        with open(self.BATTERY_CAP) as cap:
            cap_str = cap.read().strip()

        return cap_str.lower()


def quit(menu_item):
    notify.uninit()
    gtk.main_quit()

def build_menu(battery_monitor):
    menu = gtk.Menu()
    item_show = gtk.MenuItem(label='show')
    item_show.connect('activate', battery_monitor.show)
    menu.append(item_show)
    item_quit = gtk.MenuItem('quit')
    item_quit.connect('activate', quit)
    menu.append(item_quit)
    menu.show_all()
    return menu

def create_indicator(battery_monitor):
    indicator = appindicator.Indicator.new(APPINDICATOR_ID,
                           os.path.abspath(ICON_PATH),
                           appindicator.IndicatorCategory.SYSTEM_SERVICES)
    indicator.set_status(appindicator.IndicatorStatus.ACTIVE)
    indicator.set_menu(build_menu(battery_monitor))
    notify.init(APPINDICATOR_ID)
    return indicator

def main():
    bm = BatteryMonitor()
    indicator = create_indicator(bm)
    bm.show()
    gtk.main()

if __name__ == "__main__":
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    main()
