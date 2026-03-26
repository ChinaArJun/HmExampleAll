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

@Entry
@Component
struct ComponentAdvanced {
  @State themeValue: string = 'light';
  @State notifyEmail: boolean = true;
  @State notifySms: boolean = false;
  @State notifyPush: boolean = true;
  @State progressValue: number = 42;
  @State textAreaValue: string = '';

  private radioCode: string = `Radio({ value: 'light', group: 'theme' })
  .checked(this.themeValue === 'light')
  .onChange((checked: boolean) => {
    if (checked) {
      this.themeValue = 'light';
    }
  })`;

  private checkboxCode: string = `Checkbox({ name: 'email', group: 'notify' })
  .select(this.notifyEmail)
  .onChange((value: boolean) => {
    this.notifyEmail = value;
  })`;

  private progressCode: string = `Progress({ value: this.progressValue, total: 100, type: ProgressType.Linear })
  .height(10)
  .width('100%')`;

  build() {
    Scroll() {
      Column() {
        PageHeader({ title: '组件进阶' })

        Column() {
          Text('页面说明')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 6 })
          Text('本页结合官方 ArkUI 组件文档，补充表单选择与进度反馈等常见组件示例。')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('单选 Radio')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Row() {
            Column() {
              Radio({ value: 'light', group: 'theme' })
                .checked(this.themeValue === 'light')
                .onChange((checked: boolean) => {
                  if (checked) {
                    this.themeValue = 'light';
                  }
                })
              Text('浅色')
                .fontSize(12)
            }
            Column() {
              Radio({ value: 'dark', group: 'theme' })
                .checked(this.themeValue === 'dark')
                .onChange((checked: boolean) => {
                  if (checked) {
                    this.themeValue = 'dark';
                  }
                })
              Text('深色')
                .fontSize(12)
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.radioCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('多选 Checkbox')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            Row() {
              Checkbox({ name: 'email', group: 'notify' })
                .select(this.notifyEmail)
                .onChange((value: boolean) => {
                  this.notifyEmail = value;
                })
              Text('邮件通知')
                .fontSize(12)
                .margin({ left: 8 })
            }
            .margin({ bottom: 6 })
            Row() {
              Checkbox({ name: 'sms', group: 'notify' })
                .select(this.notifySms)
                .onChange((value: boolean) => {
                  this.notifySms = value;
                })
              Text('短信通知')
                .fontSize(12)
                .margin({ left: 8 })
            }
            .margin({ bottom: 6 })
            Row() {
              Checkbox({ name: 'push', group: 'notify' })
                .select(this.notifyPush)
                .onChange((value: boolean) => {
                  this.notifyPush = value;
                })
              Text('推送通知')
                .fontSize(12)
                .margin({ left: 8 })
            }
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.checkboxCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('进度与加载反馈')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            Progress({ value: this.progressValue, total: 100, type: ProgressType.Linear })
              .height(10)
              .width('100%')
            Row() {
              Text(`当前进度: ${this.progressValue}%`)
                .fontSize(12)
              LoadingProgress()
                .width(14)
                .height(14)
                .margin({ left: 8 })
            }
            .margin({ top: 8 })
            Slider({ value: this.progressValue, min: 0, max: 100, step: 1 })
              .onChange((value: number) => {
                this.progressValue = value;
              })
              .margin({ top: 8 })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.progressCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('多行输入 TextArea')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            TextArea({ text: this.textAreaValue, placeholder: '填写备注信息' })
              .height(100)
              .padding(10)
              .borderRadius(8)
              .backgroundColor('#FFFFFF')
              .border({ width: 1, color: '#E0E0E0' })
              .onChange((value: string) => {
                this.textAreaValue = value;
              })
            Text(`已输入 ${this.textAreaValue.length} 字`)
              .fontSize(12)
              .fontColor('#666666')
              .margin({ top: 6 })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 16 })
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
