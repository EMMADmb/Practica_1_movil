import 'package:home_widget/home_widget.dart';

import 'news_data.dart';

const String androidWidgetName = 'NewsWidget';

void updateHeadline(NewsArticle newHeadline) {
  // Save the headline data to the widget
  HomeWidget.saveWidgetData<String>('headline_title', newHeadline.title);
  HomeWidget.saveWidgetData<String>(
    'headline_description',
    newHeadline.description,
  );
  HomeWidget.updateWidget(androidName: androidWidgetName);
}
