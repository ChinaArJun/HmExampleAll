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

interface BasicItem {
  name: string;
  desc: string;
}

@Entry
@Component
struct ComponentBasics {
  @State clickCount: number = 0;
  @State inputText: string = '';
  @State isOn: boolean = true;
  @State sliderValue: number = 30;

  private listData: Array<BasicItem> = [
    { name: '组件一', desc: '支持图文混排与圆角' },
    { name: '组件二', desc: '支持点击与可视化状态' },
    { name: '组件三', desc: '适合列表/卡片展示' }
  ];

  private textCode: string = `Text('标题')\n  .fontSize(20)\n  .fontWeight(FontWeight.Bold)\n\nText('副标题')\n  .fontSize(14)\n  .fontColor('#666')`;

  private buttonCode: string = `@State count: number = 0;\n\nButton('点击+1')\n  .onClick(() => {\n    this.count += 1;\n  })`;

  private inputCode: string = `@State nickname: string = '';\n\nTextInput({ text: this.nickname, placeholder: '输入昵称' })\n  .onChange((value: string) => {\n    this.nickname = value;\n  })`;

  private switchSliderCode: string = `@State isOn: boolean = true;\n@State value: number = 30;\n\nToggle({ type: ToggleType.Switch, isOn: this.isOn })\n  .onChange((isOn: boolean) => {\n    this.isOn = isOn;\n  })\n\nSlider({ value: this.value, min: 0, max: 100, step: 1 })\n  .onChange((val: number) => {\n    this.value = val;\n  })`;

  private listCode: string = `ForEach(this.listData, (item: BasicItem) => {\n  Row() {\n    Image($r('app.media.startIcon')).width(32).height(32)\n    Column() {\n      Text(item.name)\n      Text(item.desc).fontSize(12).fontColor('#666')\n    }\n  }\n})`;

  build() {
    Scroll() {
      Column() {
        PageHeader({ title: '组件基础' })

        Column() {
          Text('文本与样式')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            Text('鸿蒙组件基础')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Text('支持字号、粗细、颜色等样式配置')
              .fontSize(14)
              .fontColor('#666666')
              .margin({ top: 4 })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.textCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('按钮与事件')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Row() {
            Button('点击 +1')
              .onClick(() => {
                this.clickCount += 1;
              })
            Text(`已点击 ${this.clickCount} 次`)
              .fontSize(14)
              .margin({ left: 12 })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.buttonCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('输入框与联动展示')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            TextInput({ text: this.inputText, placeholder: '输入你的昵称' })
              .height(40)
              .padding({ left: 10 })
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .border({ width: 1, color: '#E0E0E0' })
              .onChange((value: string) => {
                this.inputText = value;
              })
            Text(`你好，${this.inputText || '访客'}`)
              .fontSize(14)
              .margin({ top: 8 })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.inputCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('开关与滑条')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            Row() {
              Toggle({ type: ToggleType.Switch, isOn: this.isOn })
                .onChange((isOn: boolean) => {
                  this.isOn = isOn;
                })
              Text(this.isOn ? '已开启' : '已关闭')
                .fontSize(14)
                .margin({ left: 8 })
            }
            .margin({ bottom: 10 })

            Slider({ value: this.sliderValue, min: 0, max: 100, step: 1 })
              .onChange((value: number) => {
                this.sliderValue = value;
              })
            Text(`当前数值：${this.sliderValue}`)
              .fontSize(12)
              .fontColor('#666666')
              .margin({ top: 6 })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.switchSliderCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('列表与图片')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            ForEach(this.listData, (item: BasicItem) => {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(32)
                  .height(32)
                  .borderRadius(8)
                Column() {
                  Text(item.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                  Text(item.desc)
                    .fontSize(12)
                    .fontColor('#666666')
                    .margin({ top: 2 })
                }
                .margin({ left: 8 })
              }
              .padding(8)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .margin({ bottom: 8 })
            }, (item: BasicItem) => item.name)
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.listCode })
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
