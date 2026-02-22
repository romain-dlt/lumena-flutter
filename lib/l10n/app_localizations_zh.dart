// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get pranksCategoryLabel => '恶作剧 🔥';

  @override
  String get homelessPromptLabel => '流浪汉';

  @override
  String get homelessPromptText =>
      '在房间内添加一个逼真的流浪汉,他站在那里看着镜头,表情温暖而感激,仿佛刚被欢迎进入。完美匹配房间的照明、视角和阴影。场景必须看起来自然可信,不改变图像的任何其他部分。';

  @override
  String get plumberPromptLabel => '水管工';

  @override
  String get plumberPromptText =>
      '在房间内添加一个逼真的赤膊水管工,他穿着工作裤,拿着水管工具,正在修理管道或固定装置。他裸露的躯干看起来不合时宜且有点尴尬,增强了场景的不适感。他看起来怪异、可疑或社交不适当,表情或姿势不寻常,仿佛有些不对劲。完美匹配房间的照明、视角、阴影和倒影。场景必须看起来自然、可信且略微令人不安,不改变图像的其他任何部分。';

  @override
  String get damagedCarPromptLabel => '损坏的车';

  @override
  String get damagedCarPromptText =>
      '修改图像中的汽车,使其看起来明显因重大事故而损坏,但仍可修复且完全可识别。添加多处凹痕、更重的划痕、破裂或缺失的大灯罩、明显弯曲的保险杠或引擎盖、错位的车身面板和油漆损伤,但不要将车变成废铁或完全摧毁它。保持原始环境、照明、倒影、相机角度和构图,使损坏看起来逼真、连贯,并自然地融入场景。';

  @override
  String get dirtyToiletsPromptLabel => '脏厕所';

  @override
  String get dirtyToiletsPromptText =>
      '修改图像中的干净厕所,使其看起来非常肮脏和不卫生,仿佛长期被忽视。添加逼真的污垢、干溅痕、污渍、尿渍、水变色、脏碗残留物、座圈刮痕,以及厕所和周围区域的整体污秽。混乱程度必须严重但不过分,没有近距离的血腥或过度细节。保持原始浴室布局、照明、相机角度和比例,使结果看起来可信且令人震惊。';

  @override
  String get brokenTvPromptLabel => '破损的电视';

  @override
  String get brokenTvPromptText =>
      '修改图像中的电视,使其看起来严重损坏且无法使用,仿佛经历了严重的故障或撞击。添加破裂或破碎的屏幕、黑色死区、彩色故障线、扭曲的像素和显示伪影,同时保持电视在物理上可识别且位于原位。屏幕必须明显不工作,即使电视已打开。保持原始房间、照明、倒影、相机角度和构图,使损坏看起来逼真且令人信服。';

  @override
  String get relationshipsCategoryLabel => '关系 💞';

  @override
  String get aiGirlfriendPromptLabel => 'AI女友';

  @override
  String get aiGirlfriendPromptText =>
      '将图像重新创建为逼真的照片。添加一个自然看起来的女友站在或坐在男人旁边。她必须看起来舒适且自然地靠近,仿佛他们是真正的情侣。完美匹配照明、视角、比例和阴影。他们的互动必须感觉微妙而真实。保持男人的脸、身体和背景不变。没有风格化,没有夸张,纯粹的照片真实主义。';

  @override
  String get aiBoyfriendPromptLabel => 'AI男友';

  @override
  String get aiBoyfriendPromptText =>
      '将图像重新创建为逼真的照片。添加一个自然看起来的男友站在或坐在人旁边。他必须看起来放松且自然地靠近,仿佛他们是真正的情侣。完美匹配照明、视角、比例和阴影。他们的互动必须感觉微妙而真实。保持原人的脸、身体和背景不变。没有风格化,没有夸张,纯粹的照片真实主义。';

  @override
  String get fashionCategoryLabel => '时尚 👠';

  @override
  String get changeHairstylePromptLabel => '改变发型';

  @override
  String get changeHairstylePromptText =>
      '将图像重新创建为逼真的照片。将人的发型更改为以下内容:[HAIRSTYLE DESCRIPTION]。头发必须看起来自然,具有逼真的体积、质地和发丝。完美匹配照明、阴影、发际线和头部形状。发型必须与脸部和头皮无缝融合,没有扭曲或人工边缘。保持脸部、表情、身体和背景不变。';

  @override
  String get tattooTryOnPromptLabel => '试纹身';

  @override
  String get tattooTryOnPromptText =>
      '将图像重新创建为逼真的照片。在[BODY PART]上添加纹身,遵循此描述:[TATTOO DESCRIPTION]。纹身必须遵循皮肤的自然轮廓、曲率和肌肉结构。完美匹配皮肤纹理、毛孔、照明、阴影和视角。墨水必须看起来嵌入皮肤下方,而不是印刷或叠加。没有扭曲,没有风格化。不要改变图像中的任何其他内容。';

  @override
  String get outfitTryOnPromptLabel => '试穿服装';

  @override
  String get outfitTryOnPromptText =>
      '将图像重新创建为逼真的照片。将人身上的衣服替换为以下服装:[OUTFIT DESCRIPTION]。衣服必须自然地适合身体,遵循姿势、比例和织物行为。完美匹配照明、阴影、褶皱和视角。织物必须看起来被穿着,具有自然的褶皱和深度,而不是贴上或涂上。保持人的身体、脸部、姿势和背景不变。';

  @override
  String get transformationCategoryLabel => '变形 🪄';

  @override
  String get muscularPromptLabel => '肌肉发达';

  @override
  String get muscularPromptText =>
      '将图像重新创建为逼真的照片。调整人的姿势,使他们自然地弯曲肌肉,仿佛有意识地收紧身体。增强可见的肌肉定义和血管分布,同时保持逼真和成比例的解剖结构。弯曲的肌肉必须遵循自然的身体力学,具有准确的照明、阴影和皮肤纹理。保持脸部、表情、身份和背景不变。没有风格化,没有过度的健美外观,纯粹的照片真实主义。';

  @override
  String get professionalPromptLabel => '专业';

  @override
  String get professionalPromptText =>
      '将图像重新创建为逼真的专业肖像。保持原人和脸部不变。将他们放置在中性、干净的环境中,使用柔和、平衡的工作室照明和简单的灰色背景。给人穿上简单、优雅和专业的西装。人必须有微妙、自然的微笑和直立、自信的姿势。结果必须看起来像真正的高质量LinkedIn个人资料照片,没有风格化或人工效果。';

  @override
  String get manToWomanPromptLabel => '男变女';

  @override
  String get manToWomanPromptText =>
      '将图像中的男人转变为逼真的女性等价物。保持照片完全相同:相同的框架、相同的背景、相同的环境、相同的姿势、相同的姿态和相同的身体位置。不要扩展、裁剪或生成新的身体部位。只修改性别相关特征,同时保持身份和相似性:面部结构自然调整,特征更柔和,女性化发型,在已可见的地方有微妙的女性身体特征。保持原始照明、阴影、视角和图像质量。高度逼真,无缝集成,无视觉伪影。';

  @override
  String get womanToManPromptLabel => '女变男';

  @override
  String get womanToManPromptText =>
      '将图像中的女人转变为逼真的男性等价物。保持照片完全相同:相同的框架、相同的背景、相同的环境、相同的姿势、相同的姿态和相同的身体位置。不要扩展、裁剪或生成新的身体部位。只修改性别相关特征,同时保持身份和相似性:更强的下颌线,男性化面部特征,男性化发型,在已可见的地方有微妙的男性身体特征。保持原始照明、阴影、视角和图像质量。高度逼真,无缝集成,无视觉伪影。';

  @override
  String get animalToHumanPromptLabel => '动物变人';

  @override
  String get animalToHumanPromptText =>
      '将图像中的动物转变为逼真的人类等价物,同时保持动物的身份、姿势、态度和独特特征。人类必须清晰地感觉像同一生物的人类形式,具有可识别的面部结构、表情、肢体语言和受动物启发的存在感。保持原始环境、照明、相机角度和构图不变。转变必须看起来自然、照片逼真,并完美融入场景。';

  @override
  String get avatarsCategoryLabel => '头像 🎭';

  @override
  String get iosMemojiPromptLabel => 'iOS Memoji';

  @override
  String get iosMemojiPromptText =>
      '将人转变为iOS风格的全身Memoji角色。保持人的面部特征、发型、肤色和整体身份可识别。如果原始图像中没有显示身体部位,请以一致的方式自然想象和完成它们。使用光滑的圆形形状和柔和的颜色渲染角色,遵循官方iOS Memoji风格。使用纯白色背景。结果必须看起来像干净、精致的全身Apple Memoji。';

  @override
  String get snapchatBitmojiPromptLabel => 'Snapchat Bitmoji';

  @override
  String get snapchatBitmojiPromptText =>
      '将图像中的人重新创建为受Snapchat Bitmoji视觉启发的全身Bitmoji风格头像。保持人的面部特征、发型、肤色、表情和姿势,使他们保持清晰可识别。生成从头到脚的全身,即使原始图像中没有显示某些部分,同时保持相同的姿势和肢体语言。使用干净的卡通比例、光滑的轮廓、明亮的平面颜色和典型的Bitmoji柔和阴影。将头像放在纯白色背景上。最终结果必须看起来像代表该人的官方Bitmoji角色。';

  @override
  String get pixelArtPromptLabel => '像素艺术';

  @override
  String get pixelArtPromptText =>
      '将人转变为全身像素艺术头像。保持人的主要面部特征、发型和整体外观可识别。如果身体部位不可见,请逼真地想象和完成它们。以干净的像素艺术风格渲染头像,具有清晰的形状、有限的颜色和清晰的像素。使用纯白色背景。结果必须看起来像设计良好的全身像素角色,适合个人资料或游戏头像。';

  @override
  String get minecraftAvatarPromptLabel => 'Minecraft';

  @override
  String get minecraftAvatarPromptText =>
      '将人转变为Minecraft风格的全身角色皮肤。整个身体必须完全可见,从头到脚,没有任何东西被裁剪或缺失。保持与原始图像相同的姿势、身体位置和肢体语言。在Minecraft块状美学中保持人的面部特征、发型和整体外观可识别。如果身体部位不可见,请在严格保持原始姿势的同时自然地想象和完成它们。使用平面颜色、清晰的像素边缘,没有阴影或渐变。纯白色背景。结果必须看起来像适当的Minecraft玩家皮肤。';

  @override
  String get environmentCategoryLabel => '环境 🏞️';

  @override
  String get strangerThingsPromptLabel => '怪奇物语';

  @override
  String get strangerThingsPromptText =>
      '重新创建完全相同的图像,并将人融入怪奇物语世界。保持主要主体完全逼真且不变(脸部、身体、衣服、姿势、表情)。转变整个环境以匹配怪奇物语的氛围:不祥的暴风天空(无雨)、发光的深红色云层和照亮场景的红色闪电。将怪奇物语中的Mind Flayer清晰可见地放置在远处的天空中,巨大而威胁,部分被云层笼罩,忠实于该系列的设计。保持原始构图、视角和相机角度。场景必须感觉电影化、黑暗、超自然,并明确受怪奇物语启发,仿佛照片是在Upside Down事件期间拍摄的。';

  @override
  String get minecraftEnvironmentPromptLabel => 'Minecraft';

  @override
  String get minecraftEnvironmentPromptText =>
      '重新创建完全相同的图像,但将整个环境转变为Minecraft世界。使用官方Minecraft方块、纹理和比例严格重建背景。不要修改主要主体(人),保持他们完全逼真且不变。将所有其他人、动物、物体和交互元素转变为他们的Minecraft等价物(例如狗=Minecraft狼,一杯水=Minecraft水桶)。保持原始构图、相机角度、视角和位置。结果必须看起来像在Minecraft内拍摄的真实照片,主体站在真实世界中。';

  @override
  String get legoPromptLabel => '乐高';

  @override
  String get legoPromptText =>
      '重新创建完全相同的图像,但将整个环境转变为乐高世界。使用乐高积木、螺柱、塑料纹理和乐高比例重建背景。不要修改主要主体(人),保持他们完全逼真且不变。将所有其他人、动物和物体转变为他们的乐高等价物(迷你人偶、乐高动物、乐高配件)。保持原始构图、相机角度、视角和位置。最终图像必须看起来像在乐高世界内拍摄的真实照片,真实主体站在乐高元素之间。';

  @override
  String get filtersCategoryLabel => '滤镜 📸';

  @override
  String get fisheyeLensPromptLabel => '鱼眼镜头';

  @override
  String get fisheyeLensPromptText =>
      '保持原始图像和主体完全原样。应用逼真的高端鱼眼相机镜头效果,仿佛照片是非常靠近脸部拍摄的。强烈的广角扭曲,具有明显的鱼眼曲率:靠近镜头的面部特征被放大,边缘弯曲,微妙的桶形扭曲。保持自然的皮肤纹理、逼真的比例和准确的照明。高质量的相机外观,清晰的焦点,没有人工或卡通效果。结果必须看起来像用专业鱼眼镜头拍摄的真实特写照片。';

  @override
  String get oldPhotoRestorePromptLabel => '修复旧照片';

  @override
  String get oldPhotoRestorePromptText =>
      '保持原始构图、人物、面部特征、姿势和背景与源图像完全相同。完全修复这张旧的、受损的黑白或褪色照片,使其看起来像今天用现代高端相机拍摄的。修复划痕、污垢、撕裂、模糊和噪点。自然重建缺失的细节,不改变身份。添加逼真的现代着色,具有准确的肤色和材料、平衡的对比度、清晰的焦点和干净的照明。没有艺术重新诠释,没有风格化,没有AI伪影。最终结果必须看起来像真正的当代照片,而不是编辑或着色的旧照片。';

  @override
  String get woolPromptLabel => '羊毛';

  @override
  String get woolPromptText =>
      '重新生成完全相同的图像,但将所有内容都制作成厚实、致密的羊毛和针毡织物。每个元素必须具有可见的粗纤维、重纱线、毡化纹理、柔和模糊的边缘和清晰的纺织品体积。没有油漆,没有塑料,没有粘土,没有CGI,只有厚羊毛。保持精确的构图、视角、姿势和比例。颜色必须看起来像染色的纱线。照明必须揭示纤维的深度和柔软度。结果必须看起来像物理羊毛雕塑,毫无疑问地由厚羊毛制成。';

  @override
  String get settings => '设置';

  @override
  String get account => '账户';

  @override
  String get lumenaPro => 'LUMENA PRO';

  @override
  String get legal => '法律';

  @override
  String get website => '网站';

  @override
  String get legalNotice => '法律声明';

  @override
  String get termsOfService => '使用条款';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get restoreFailed => '恢复失败';

  @override
  String get restoreFailedDescription => '恢复您的购买时发生错误，请重试。';

  @override
  String get changePlan => '更改套餐';

  @override
  String get manage => '管理';

  @override
  String get upgrade => '升级';

  @override
  String get signOut => '退出登录';

  @override
  String get signOutConfirmation => '确定要退出登录吗？';

  @override
  String get signOutDescription => '您需要重新登录才能访问账户。';

  @override
  String get cancel => '取消';

  @override
  String get monthlyEditsUsage => '每月用量';

  @override
  String get signInToView => '登录后查看';

  @override
  String remaining(int remaining, int max) {
    String _temp0 = intl.Intl.pluralLogic(
      remaining,
      locale: localeName,
      other: '$remaining / $max 剩余',
      one: '$remaining / $max 剩余',
      zero: '$remaining / $max 剩余',
    );
    return '$_temp0';
  }

  @override
  String get counting => '计算中…';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get restore => '恢复';

  @override
  String get noPurchases => '无购买记录';

  @override
  String get noPurchasesDescription => '未找到与您账户关联的任何过往购买。';

  @override
  String get restoreSuccessful => '恢复成功';

  @override
  String get restoreSuccessfulDescription =>
      '您的购买已成功恢复！现在即可尽享 Lumena PRO 的全部功能。';

  @override
  String get email => '邮箱';

  @override
  String get signIn => '登录';

  @override
  String get imageSavedToGallery => '图片已保存';

  @override
  String get failedToSaveImage => '保存失败';

  @override
  String get imageSavedToGalleryDescription => '图片已成功保存到您的相册。';

  @override
  String get failedToSaveImageDescription => '保存图片时发生错误，请重试。';

  @override
  String get imageShareDescription => '看看我用 Lumena AI 编辑的图片吧！✨';

  @override
  String get unexpectedError => '意外错误';

  @override
  String get unexpectedErrorImageGenerationDescription => '生成图片时发生错误，请重试。';

  @override
  String get exitConfirmTitle => '确定要退出吗？';

  @override
  String get exitConfirmDescription => '退出此页面将丢失所有未保存的修改。';

  @override
  String get exit => '退出';

  @override
  String get stayHere => '留在此处';

  @override
  String get photoEditor => '编辑器';

  @override
  String editsRemainingThisMonth(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '本月剩余 $count 次修改',
      one: '本月剩余 1 次修改',
      zero: '本月无剩余修改',
    );
    return '$_temp0';
  }

  @override
  String get checkingEditBalance => '正在检查您的修改余额…';

  @override
  String get keepEditing => '继续编辑';

  @override
  String get download => '下载';

  @override
  String get share => '分享';

  @override
  String get generate => '生成';

  @override
  String get promptInputPlaceholder => '输入你想要的修改内容…';

  @override
  String get pictureInputPlaceholder => '点击选择';

  @override
  String get loadingSubtitle1 => '塑造无形之物…';

  @override
  String get loadingSubtitle2 => '编织数字梦境…';

  @override
  String get loadingSubtitle3 => '用像素作画…';

  @override
  String get loadingSubtitle4 => '创造视觉魔法…';

  @override
  String get loadingSubtitle5 => '弯曲现实…';

  @override
  String get loadingSubtitle6 => '唤醒想象力…';

  @override
  String get loadingSubtitle7 => '雕刻光影…';

  @override
  String get loadingSubtitle8 => '突破边界…';

  @override
  String get lumenaAI => 'Lumena AI';

  @override
  String get imageSource => '图片来源';

  @override
  String get imageSourceDescription => '选择你想要编辑的图片来源。';

  @override
  String get camera => '相机';

  @override
  String get gallery => '相册';

  @override
  String get premiumHookTitle => '**免费** 体验 **Lumena PRO**';

  @override
  String get continueButton => '继续';

  @override
  String get howFreeTrialWorks => '**免费** 试用如何运作';

  @override
  String get step1Title => '今天';

  @override
  String get step1Description => '解锁 Lumena PRO 访问权限';

  @override
  String get step2Title => '2 天后';

  @override
  String get step2Description => '试用结束前我们会提醒你';

  @override
  String get step3Title => '3 天后';

  @override
  String get step3Description => '若未提前取消，PRO 订阅将自动开始';

  @override
  String get threeDayFreeTrial => '3 天免费试用';

  @override
  String get notEligibleForFreeTrial => '您不再有资格享受免费试用';

  @override
  String get freeTrialExpirationTitle => '您的免费试用即将结束！';

  @override
  String get freeTrialExpirationBody => '您的3天免费试用将在24小时后到期。继续享受Lumena PRO！';

  @override
  String get monthly => '月付';

  @override
  String pricePerMonth(String price) {
    return '$price / 月';
  }

  @override
  String get weekly => '周付';

  @override
  String pricePerWeek(String price) {
    return '$price / 周';
  }

  @override
  String subscribeForPrice(String price) {
    return '以 $price 订阅';
  }

  @override
  String get noCommitmentCancelAnytime => '无合约，随时可取消。';

  @override
  String editsPerMonth(int edits) {
    return '每月 $edits 次修改';
  }

  @override
  String get purchaseFailure => '购买失败';

  @override
  String get purchaseFailureDescription => '购买过程中发生错误，请重试。';

  @override
  String get congratulations => '恭喜！';

  @override
  String get congratulationsDescription => '您已成为 Lumena PRO 会员！现在可以尽情使用全部功能。';

  @override
  String get okay => '好的';

  @override
  String get parametersReminderTitle => '别忘了参数！';

  @override
  String get parametersReminderDescription =>
      '此提示包含括号中的参数（例如，[BODY PART]、[DESCRIPTION]）。在生成图像之前，请确保用您自己的文本替换它们。';

  @override
  String get alreadyPro => '已是 PRO';

  @override
  String get alreadyProDescription => '您已是 PRO 会员，请前往设置管理订阅。';

  @override
  String get welcomeToLumena => '欢迎使用 Lumena';

  @override
  String get editAnythingWithText => '用文字编辑一切';

  @override
  String get getStarted => '开始使用';

  @override
  String get linkedLegalNotice => '继续即表示您同意我们的[使用条款]和[隐私政策]。';

  @override
  String get next => '下一步';

  @override
  String get chooseYourPicture => '选择你的图片';

  @override
  String get typeYourEdit => '输入你的修改';

  @override
  String get examplePromptGirlfriend => '给我加一个女朋友';

  @override
  String get watchItTurnReal => '看它变为现实';

  @override
  String get currentPlan => '当前套餐';

  @override
  String get changeYourPlanToWeekly => '切换为周付套餐';

  @override
  String get changeYourPlanToMonthly => '切换为月付套餐';

  @override
  String get weeklyPlan => '周付套餐';

  @override
  String get monthlyPlan => '月付套餐';

  @override
  String get month => '月';

  @override
  String get week => '周';

  @override
  String get upgradeToMonthly => '升级为月付';

  @override
  String get switchToWeekly => '切换为周付';

  @override
  String get cancelSubscription => '取消订阅';

  @override
  String get subscriptionActiveNotice => '您的订阅将在当前计费周期结束前保持有效';

  @override
  String get cancelSubscriptionQuestion => '取消订阅？';

  @override
  String get cancelSubscriptionQuestionDescription =>
      '确定要取消 Lumena PRO 订阅吗？在当前计费周期结束后，您将失去高级功能的访问权限。';

  @override
  String get keepPro => '保留 PRO';

  @override
  String get cancelSubscriptionDescription =>
      '如需取消 Lumena PRO 订阅，请前往 Google Play 商店的订阅设置。';

  @override
  String get fetchingPrice => '正在获取价格…';

  @override
  String get unableToDetectCurrentPlan => '无法检测当前套餐';

  @override
  String get unableToDetectCurrentPlanDescription => '请稍后重试，或联系支持人员。';

  @override
  String get planChanged => '套餐已更改';

  @override
  String get planChangedDescription => '您的订阅套餐已更新。';

  @override
  String get planChangeFailed => '套餐更改失败';

  @override
  String get planChangeFailedDescription => '无法更改订阅套餐，请重试。';

  @override
  String get signInToContinue => '登录以继续';

  @override
  String get continueWithGoogle => '使用 Google 继续';

  @override
  String get noEditsRemaining => '无剩余修改';

  @override
  String get noEditsRemainingDescriptionPro => '您已用完本月的所有修改次数，请下个月再来！';

  @override
  String get noEditsRemainingDescriptionNonPro =>
      '您需要 PRO 才能编辑图像。请升级到 PRO 以继续。';

  @override
  String get noInternetConnectionTitle => '无互联网连接';

  @override
  String get noInternetConnectionDescription => '此应用需要互联网连接才能运行。请检查您的连接并重试。';

  @override
  String get upgradeToPro => '升级到PRO';

  @override
  String get rateUsTitle => '喜欢Lumena吗？';

  @override
  String get rateUsDescription =>
      '如果您喜欢使用Lumena AI，您介意花点时间为其评分吗？不会超过一分钟。感谢您的支持！';

  @override
  String get rateUsButton => '评价';

  @override
  String get noThanks => '不用了，谢谢';
}
