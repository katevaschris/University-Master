import ssl
import sys
import os
import random
from threading import Timer
from datetime import datetime

import paho.mqtt.client as mqtt
import matplotlib.pyplot as plt
from matplotlib.widgets import Button


class IoTExample:
    def __init__(self):
        self._timer_obj = None
        self._establish_mqtt_connection()
        self._prepare_graph_window()
        print('Class is created')

    def _establish_mqtt_connection(self):
        self.client = mqtt.Client()
        self.client.on_connect = self._on_connect
        self.client.on_log = self._on_log
        self.client.on_message = self._on_message
        self.client.tls_set_context(ssl.SSLContext(ssl.PROTOCOL_TLSv1_2))
        self.client._client_id = f"iot_lesson_{random.randint(0,999999)}".encode(
            'utf-8')
        self.client.username_pw_set('iotlesson', 'iotlesson123456!')
        self.client.connect('kube.cs.uowm.gr', 8883)

    def start(self):
        print('Starting')
        self.client.loop_start()
        plt.show()

    def _on_connect(self, client, userdata, flags, rc):
        print("Client is connected")
        self.client.subscribe('iotlesson_eventbus/grafeio113/out/#')

    def _on_log(self, client, userdata, level, buf):
        print(f"Log: {buf}")

    def _on_message(self, client, userdata, msg):
        print(f"Message topic: {msg.topic}")
        print(f"Message data: {msg.payload.decode('utf-8')}")

        if msg.topic == 'iotlesson_eventbus/grafeio113/out/ZWave_8_Metered_Wall_Plug_Switch_on_desk_Sensor_power/state':
            self._add_value_to_plot(float(msg.payload))

        if msg.topic == 'iotlesson_eventbus/grafeio113/out/ZWave_8_Metered_Wall_Plug_Switch_on_desk_Switch/state':
            self.state_field.set_text(f'STATE: {msg.payload.decode("utf-8")}')
            if msg.payload.decode("utf-8") == 'ON':
                self.state_field.set_color('g')
            elif msg.payload.decode("utf-8") == 'OFF':
                self.state_field.set_color('r')
            else:
                self.state_field.set_color('k')

    def _button_on_clicked(self, event):
        self.client.publish(
            'iotlesson_eventbus/grafeio113/in/ZWave_8_Metered_Wall_Plug_Switch_on_desk_Switch/command', 'ON')

    def _button_off_clicked(self, event):
        self.client.publish(
            'iotlesson_eventbus/grafeio113/in/ZWave_8_Metered_Wall_Plug_Switch_on_desk_Switch/command', 'OFF')

    def disconnect(self, args=None):
        self.finishing = True
        if self._timer_obj:
            self._timer_obj.cancel()
        self.client.disconnect()

    def _prepare_graph_window(self):
        plt.rcParams['toolbar'] = 'None'
        self.ax = plt.subplot(111)
        self.dataX = []
        self.dataY = []
        self.first_ts = datetime.now()
        self.lineplot, = self.ax.plot(
            self.dataX,
            self.dataY,
            linestyle='--',
            marker='o',
            color='b',
        )
        
        axcut_on = plt.axes([0.0, 0.0, 0.1, 0.06])
        self.bcut_on = Button(axcut_on, 'ON')

        axcut_off = plt.axes([0.1, 0.0, 0.1, 0.06])
        self.bcut_off = Button(axcut_off, 'OFF')
        
        self.bcut_on.on_clicked(self._button_on_clicked)
        self.bcut_off.on_clicked(self._button_off_clicked)
        
        self.state_field = plt.text(1.5, 0.3, 'STATE: -')
        
        self.ax.figure.canvas.mpl_connect(
            'close_event',
            self.disconnect
        )
        self.finishing = False
        self._my_timer()

    def _add_value_to_plot(self, value):
        self.dataX.append(datetime.now())
        self.dataY.append(value)
        self.lineplot.set_data(self.dataX, self.dataY)
        self._refresh_plot()

    def _refresh_plot(self):
        if len(self.dataX) > 0:
            self.ax.set_xlim(
                min(self.first_ts, *self.dataX),
                max(*self.dataX, datetime.now()),
            )
            self.ax.set_ylim(0, max(self.dataY) * 1.2)
        else:
            self.ax.set_xlim(self.first_ts, datetime.now())
        self.ax.relim()
        plt.draw()

    def _my_timer(self):
        if not self.finishing:
            self._refresh_plot()
            self._timer_obj = Timer(1.0, self._my_timer)
            self._timer_obj.start()


try:
    iot_example = IoTExample()
    iot_example.start()
except KeyboardInterrupt:
    print('Interrupted')
    try:
        plt.close()
        iot_example.disconnect()
        sys.exit(0)
    except SystemExit:
        os._exit(0)
