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

class BatteryMonitor:

    """Battery monitoring class"""

    APPINDICATOR_ID = 'batterymonitor'
    BATTERY = "/sys/class/power_supply/BAT0/"
    BATTERY_CAP = BATTERY + "capacity"
    BATTERY_STAT = BATTERY + "status"
    ICON_PATH = '/usr/share/icons/Adwaita/24x24/devices/battery.png'
    UPDATE_INTERVAL = 300 # seconds
    LOW_THRESHOLD = 30

    def __init__(self):
        self.indicator = appindicator.Indicator.new(self.APPINDICATOR_ID,
                               os.path.abspath(self.ICON_PATH),
                               appindicator.IndicatorCategory.SYSTEM_SERVICES)
        self.indicator.set_status(appindicator.IndicatorStatus.ACTIVE)
        self.indicator.set_menu(self.build_menu())
        notify.init(self.APPINDICATOR_ID)
        glib.timeout_add_seconds(self.UPDATE_INTERVAL, self.timer)

    def timer(self):
        with open(self.BATTERY_STAT) as stat:
            stat_str = stat.read().strip()

        if stat_str.lower() == 'discharging':
            self.show(None, stat_str)

        return True

    def build_menu(self):
        menu = gtk.Menu()
        item_show = gtk.MenuItem(label='show')
        item_show.connect('activate', self.show)
        menu.append(item_show)
        item_quit = gtk.MenuItem('quit')
        item_quit.connect('activate', self.quit)
        menu.append(item_quit)
        menu.show_all()
        return menu

    def show(self, menu_item=None, stat_str=None):
        if stat_str is None:
            with open(self.BATTERY_STAT) as stat:
                stat_str = stat.read().strip()

        with open(self.BATTERY_CAP) as cap:
            cap_str = cap.read().strip()
            message = "%s (%s)" % (cap_str, stat_str)
            notification = notify.Notification.new(
                                                  "<b>Battery Status:<br></b>",
                                                  message, None)
            if int(cap_str) <= self.LOW_THRESHOLD:
                notification.set_urgency(2)

            notification.show()

    def start(self):
        gtk.main()

    def quit(self, menu_item):
        notify.uninit()
        gtk.main_quit()


def main():
    bm = BatteryMonitor()
    bm.show()
    bm.start()

if __name__ == "__main__":
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    main()
