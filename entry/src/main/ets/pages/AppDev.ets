import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

AppStorage.SetOrCreate('noticeEnabled', true);

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
struct AppDev {
  @State phone: string = '';
  @State phoneError: string = '';

  @StorageLink('noticeEnabled') noticeEnabled: boolean = true;

  private routeCode: string = `Button('进入详情页')\n  .onClick(() => {\n    router.pushUrl({ url: 'pages/RouteDemo' })\n  })`;

  private formCode: string = `const ok = /^1\\d{10}$/.test(this.phone);\nthis.phoneError = ok ? '' : '请输入11位手机号';`;

  private toastCode: string = `promptAction.showToast({ message: '保存成功' })`;

  private storageCode: string = `@StorageLink('noticeEnabled') noticeEnabled: boolean;\n\nToggle({ type: ToggleType.Switch, isOn: this.noticeEnabled })\n  .onChange((isOn) => this.noticeEnabled = isOn)`;

  private validatePhone(): void {
    const ok = /^1\d{10}$/.test(this.phone);
    this.phoneError = ok ? '' : '请输入11位手机号';
  }

  build() {
    Scroll() {
      Column() {
        PageHeader({ title: '应用程序开发' })

        Column() {
          Text('页面路由')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            Text('点击按钮进入路由示例页')
              .fontSize(12)
              .fontColor('#666666')
              .margin({ bottom: 6 })
            Button('进入示例页')
              .onClick(() => {
                router.pushUrl({ url: 'pages/RouteDemo' });
              })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.routeCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('表单校验')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            TextInput({ text: this.phone, placeholder: '请输入手机号' })
              .height(40)
              .padding({ left: 10 })
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .border({ width: 1, color: '#E0E0E0' })
              .onChange((value: string) => {
                this.phone = value;
              })
            Button('校验')
              .fontSize(12)
              .height(30)
              .margin({ top: 8 })
              .onClick(() => {
                this.validatePhone();
              })
            if (this.phoneError) {
              Text(this.phoneError)
                .fontSize(12)
                .fontColor('#D93026')
                .margin({ top: 6 })
            }
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.formCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('提示与反馈')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            Button('保存设置')
              .fontSize(12)
              .height(30)
              .onClick(() => {
                promptAction.showToast({ message: '保存成功' });
              })
          }
          .padding(12)
          .backgroundColor('#F7F8FA')
          .borderRadius(8)
          .margin({ bottom: 12 })

          CodeBlock({ code: this.toastCode })
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('设置持久化')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Column() {
            Row() {
              Toggle({ type: ToggleType.Switch, isOn: this.noticeEnabled })
                .onChange((isOn: boolean) => {
                  this.noticeEnabled = isOn;
                })
              Text(this.noticeEnabled ? '通知已开启' : '通知已关闭')
                .fontSize(12)
                .margin({ left: 8 })
            }
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
