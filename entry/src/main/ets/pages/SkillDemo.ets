import router from '@ohos.router';
import { taskpool } from '@kit.ArkTS';

@Concurrent
function sumRange(start: number, end: number): number {
  let total: number = 0;
  for (let i = start; i <= end; i++) {
    total += i;
  }
  return total;
}

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
struct SkillDemo {
  @State resultText: string = '未执行';
  @State isRunning: boolean = false;
  @State lastRange: string = '1..100000';
  @State durationMs: number = 0;

  private codeSnippet: string = `@Concurrent
function sumRange(start: number, end: number): number {
  let total: number = 0;
  for (let i = start; i <= end; i++) {
    total += i;
  }
  return total;
}

const task = new taskpool.Task(sumRange, 1, 100000);
const result = await taskpool.execute(task);`;

  private async runDemo(end: number): Promise<void> {
    if (this.isRunning) {
      return;
    }

    this.isRunning = true;
    this.lastRange = `1..${end}`;
    this.resultText = '执行中...';
    this.durationMs = 0;

    const startTime: number = Date.now();
    const task: taskpool.Task = new taskpool.Task(sumRange, 1, end);

    try {
      const result = await taskpool.execute(task);
      const endTime: number = Date.now();
      this.durationMs = endTime - startTime;
      this.resultText = `结果: ${result}`;
    } catch (error) {
      this.resultText = '执行失败';
      this.durationMs = 0;
    } finally {
      this.isRunning = false;
    }
  }

  build() {
    Scroll() {
      Column() {
        PageHeader({ title: 'Skills Demo' })

        Column() {
          Text('页面说明')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 6 })
          Text('本页演示 TaskPool 并发计算，配合 @Concurrent 在后台线程执行计算任务。')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('TaskPool 并发计算')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })

          Row() {
            Button('计算 1..100000')
              .onClick(() => {
                this.runDemo(100000);
              })
            Button('计算 1..500000')
              .margin({ left: 12 })
              .onClick(() => {
                this.runDemo(500000);
              })
          }
          .margin({ bottom: 12 })

          if (this.isRunning) {
            Row() {
              LoadingProgress()
                .width(16)
                .height(16)
                .margin({ right: 8 })
              Text('任务执行中...')
                .fontSize(12)
                .fontColor('#666666')
            }
            .margin({ bottom: 8 })
          }

          Text(`范围: ${this.lastRange}`)
            .fontSize(12)
            .fontColor('#666666')
            .margin({ bottom: 4 })
          Text(this.resultText)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 4 })
          Text(`耗时: ${this.durationMs} ms`)
            .fontSize(12)
            .fontColor('#666666')
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('核心代码')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          CodeBlock({ code: this.codeSnippet })
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
