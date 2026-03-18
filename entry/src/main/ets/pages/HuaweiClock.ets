import router from '@ohos.router';

@Component
struct PageHeader {
  @Prop title: string;

  build() {
    Row() {
      Text('返回')
        .fontSize(14)
        .fontColor('#3B6EF5')
        .padding({ right: 12 })
        .onClick(() => {
          router.back();
        })
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .padding({ bottom: 12 })
  }
}

@Component
struct CodeBlock {
  @Prop code: string;

  build() {
    Text(this.code)
      .fontSize(12)
      .fontFamily('monospace')
      .fontColor('#1F2A44')
      .lineHeight(18)
      .padding(12)
      .backgroundColor('#EEF3FF')
      .borderRadius(8)
      .width('100%')
  }
}

interface Alarm {
  id: string;
  time: string;
  label: string;
  enabled: boolean;
}

@Entry
@Component
struct HuaweiClock {
  @State currentTime: string = '';
  @State alarms: Array<Alarm> = [
    { id: 'a1', time: '07:30', label: '起床', enabled: true },
    { id: 'a2', time: '12:20', label: '午休', enabled: false },
    { id: 'a3', time: '21:30', label: '锻炼提醒', enabled: true }
  ];

  private timerId: number = -1;

  private updateTime(): void {
    const now = new Date();
    const hh = now.getHours().toString().padStart(2, '0');
    const mm = now.getMinutes().toString().padStart(2, '0');
    const ss = now.getSeconds().toString().padStart(2, '0');
    this.currentTime = `${hh}:${mm}:${ss}`;
  }

  private toggleAlarm(index: number, enabled: boolean): void {
    const next: Array<Alarm> = [];
    for (let i = 0; i < this.alarms.length; i++) {
      const alarm = this.alarms[i];
      if (i === index) {
        next.push({
          id: alarm.id,
          time: alarm.time,
          label: alarm.label,
          enabled: enabled
        });
      } else {
        next.push(alarm);
      }
    }
    this.alarms = next;
  }

  private addAlarm(): void {
    const now = new Date();
    now.setHours((now.getHours() + 1) % 24);
    const hh = now.getHours().toString().padStart(2, '0');
    const mm = now.getMinutes().toString().padStart(2, '0');
    const newAlarm: Alarm = {
      id: `a${Date.now()}`,
      time: `${hh}:${mm}`,
      label: '新闹钟',
      enabled: true
    };
    const next: Array<Alarm> = this.alarms.slice();
    next.push(newAlarm);
    this.alarms = next;
  }

  private clockCode: string = `aboutToAppear() {\n  this.updateTime();\n  this.timerId = setInterval(() => {\n    this.updateTime();\n  }, 1000) as number;\n}`;

  private alarmCode: string = `Toggle({ type: ToggleType.Switch, isOn: alarm.enabled })\n  .onChange((isOn: boolean) => {\n    this.toggleAlarm(index, isOn);\n  })`;

  aboutToAppear() {
    this.updateTime();
    this.timerId = setInterval(() => {
      this.updateTime();
    }, 1000) as number;
  }

  aboutToDisappear() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  build() {
    Scroll() {
      Column() {
        PageHeader({ title: '华为闹钟' })

        Column() {
          Text('当前时间')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 6 })
          Text(this.currentTime)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 8 })
          Button('新增闹钟')
            .fontSize(12)
            .height(30)
            .onClick(() => {
              this.addAlarm();
            })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('闹钟列表')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })

          Column() {
            ForEach(this.alarms, (alarm: Alarm, index: number) => {
              Row() {
                Column() {
                  Text(alarm.time)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                  Text(alarm.label)
                    .fontSize(12)
                    .fontColor('#666666')
                    .margin({ top: 2 })
                }
                .layoutWeight(1)
                Toggle({ type: ToggleType.Switch, isOn: alarm.enabled })
                  .onChange((isOn: boolean) => {
                    this.toggleAlarm(index, isOn);
                  })
              }
              .padding(12)
              .backgroundColor('#F7F8FA')
              .borderRadius(10)
              .margin({ bottom: 10 })
            }, (alarm: Alarm) => alarm.id)
          }
          .margin({ bottom: 12 })

          CodeBlock({ code: this.alarmCode })
          CodeBlock({ code: this.clockCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 16 })
      }
      .padding(16)
      .width('100%')
    }
    .height('100%')
    .backgroundColor('#F4F6F8')
  }
}
