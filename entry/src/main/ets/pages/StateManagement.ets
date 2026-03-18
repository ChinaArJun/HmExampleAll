import router from '@ohos.router';

AppStorage.SetOrCreate('profileName', '小明');
AppStorage.SetOrCreate('autoSync', true);

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

@Component
struct ChildEditor {
  @Link message: string;

  build() {
    Row() {
      Text(this.message)
        .fontSize(14)
      Button('追加!')
        .fontSize(12)
        .height(28)
        .margin({ left: 10 })
        .onClick(() => {
          this.message = `${this.message}!`;
        })
    }
  }
}

@Entry
@Component
struct StateManagement {
  @State count: number = 0;
  @State message: string = '状态提升示例';

  @StorageLink('profileName') profileName: string = '小明';
  @StorageLink('autoSync') autoSync: boolean = true;

  private stateCode: string = `@State count: number = 0;\n\nButton('点击')\n  .onClick(() => this.count += 1)`;

  private linkCode: string = `@Component\nstruct ChildEditor {\n  @Link message: string;\n\n  Button('追加')\n    .onClick(() => this.message = this.message + '!')\n}`;

  private storageCode: string = `AppStorage.SetOrCreate('autoSync', true);\n\n@StorageLink('autoSync') autoSync: boolean;\nToggle({ type: ToggleType.Switch, isOn: this.autoSync })\n  .onChange((isOn: boolean) => this.autoSync = isOn)`;

  build() {
    Scroll() {
      Column() {
        PageHeader({ title: '状态管理' })

        Column() {
          Text('页面说明')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 6 })
          Text('本页覆盖三类常用状态：@State（局部状态）、@Link（父子同步）、AppStorage（跨组件共享）。')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
            .margin({ bottom: 4 })
          Text('• @State：用计数器演示局部状态的自更新机制')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
          Text('• @Link：子组件修改父组件的 message，实现双向联动')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
          Text('• AppStorage：昵称输入与开关状态共享到全局')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
          Text('• 每个模块都保留示例代码，便于对照理解数据流向')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('@State：局部状态')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Row() {
            Button('减一')
              .onClick(() => {
                this.count -= 1;
              })
            Text(`${this.count}`)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 12, right: 12 })
            Button('加一')
              .onClick(() => {
                this.count += 1;
              })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.stateCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('@Prop/@Link：父子联动')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            Text(`父组件内容：${this.message}`)
              .fontSize(14)
            ChildEditor({ message: this.message })
              .margin({ top: 8 })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.linkCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('AppStorage：跨组件共享')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            Text('修改昵称会写入全局状态')
              .fontSize(12)
              .fontColor('#666666')
              .margin({ bottom: 6 })
            TextInput({ text: this.profileName, placeholder: '输入昵称' })
              .height(40)
              .padding({ left: 10 })
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .border({ width: 1, color: '#E0E0E0' })
              .onChange((value: string) => {
                this.profileName = value;
              })
            Row() {
              Toggle({ type: ToggleType.Switch, isOn: this.autoSync })
                .onChange((isOn: boolean) => {
                  this.autoSync = isOn;
                })
              Text(this.autoSync ? '自动同步开启' : '自动同步关闭')
                .fontSize(12)
                .margin({ left: 8 })
            }
            .margin({ top: 8 })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.storageCode })
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
