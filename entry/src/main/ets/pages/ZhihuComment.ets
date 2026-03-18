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

interface Reply {
  user: string;
  content: string;
  time: string;
}

interface Comment {
  id: string;
  user: string;
  content: string;
  time: string;
  likes: number;
  replies: Array<Reply>;
}

@Component
struct CommentItem {
  @Prop comment: Comment;
  @State liked: boolean = false;
  @State likeCount: number = 0;

  aboutToAppear() {
    this.likeCount = this.comment.likes;
  }

  private toggleLike(): void {
    this.liked = !this.liked;
    this.likeCount = this.likeCount + (this.liked ? 1 : -1);
  }

  build() {
    Column() {
      Row() {
        Text(this.comment.user.substring(0, 1))
          .width(36)
          .height(36)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .backgroundColor('#FFE6CC')
          .borderRadius(18)
        Column() {
          Row() {
            Text(this.comment.user)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
            Text(this.comment.time)
              .fontSize(11)
              .fontColor('#8C8C8C')
              .margin({ left: 8 })
          }
          Text(this.comment.content)
            .fontSize(14)
            .fontColor('#333333')
            .margin({ top: 4 })
        }
        .margin({ left: 10 })
      }

      Row() {
        Text(`赞 ${this.likeCount}`)
          .fontSize(12)
          .fontColor(this.liked ? '#FF6A00' : '#666666')
        Button(this.liked ? '已赞' : '点赞')
          .fontSize(12)
          .height(28)
          .margin({ left: 10 })
          .onClick(() => {
            this.toggleLike();
          })
        Text('回复')
          .fontSize(12)
          .fontColor('#666666')
          .margin({ left: 12 })
      }
      .margin({ top: 8 })

      if (this.comment.replies.length > 0) {
        Column() {
          ForEach(this.comment.replies, (reply: Reply) => {
            Row() {
              Text(reply.user)
                .fontSize(12)
                .fontColor('#3B6EF5')
              Text(`：${reply.content}`)
                .fontSize(12)
                .fontColor('#333333')
              Text(reply.time)
                .fontSize(10)
                .fontColor('#999999')
                .margin({ left: 6 })
            }
            .margin({ bottom: 4 })
          }, (reply: Reply) => reply.user + reply.time)
        }
        .padding(8)
        .backgroundColor('#F7F8FA')
        .borderRadius(8)
        .margin({ top: 8 })
      }
    }
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

@Entry
@Component
struct ZhihuComment {
  private comments: Array<Comment> = [
    {
      id: 'c1',
      user: '海风同学',
      content: '鸿蒙组件的组合能力很强，布局也很灵活。',
      time: '2小时前',
      likes: 24,
      replies: [
        { user: '小北', content: '同感，特别是ArkUI的声明式开发', time: '1小时前' },
        { user: '阿紫', content: '样式也很容易统一管理', time: '50分钟前' }
      ]
    },
    {
      id: 'c2',
      user: '产品汪',
      content: '希望能有更多官方组件的组合示例。',
      time: '5小时前',
      likes: 12,
      replies: []
    }
  ];

  private commentCode: string = `@Component\nstruct CommentItem {\n  @Prop comment: Comment;\n  @State liked: boolean = false;\n\n  Row() {\n    Text(comment.user)\n    Text(comment.content)\n  }\n\n  Button(liked ? '已赞' : '点赞')\n    .onClick(() => this.liked = !this.liked)\n}`;

  build() {
    Scroll() {
      Column() {
        PageHeader({ title: '知乎评论' })

        Column() {
          Text('页面说明')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 6 })
          Text('本页还原“评论区”的核心交互：头像/昵称、时间、评论内容、点赞与回复，以及回复列表的层级展示。')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
            .margin({ bottom: 4 })
          Text('• 头像展示：使用首字母圆形徽标替代图片，保持原生控件一致性')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
          Text('• 点赞逻辑：每条评论独立状态，点击切换颜色与计数')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
          Text('• 回复列表：二级 ForEach 渲染，便于展示层级关系')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
          Text('• 可扩展：可在底部加入输入框与发布按钮（示例保留扩展位）')
            .fontSize(12)
            .fontColor('#666666')
            .lineHeight(18)
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .margin({ bottom: 12 })

        Column() {
          Text('评论列表与交互')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })

          Column() {
            ForEach(this.comments, (comment: Comment) => {
              CommentItem({ comment: comment })
                .margin({ bottom: 12 })
            }, (comment: Comment) => comment.id)
          }
          .margin({ bottom: 12 })

          CodeBlock({ code: this.commentCode })
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
