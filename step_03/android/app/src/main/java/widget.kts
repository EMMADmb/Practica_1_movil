// Lógica de ejemplo para el App Widget (Kotlin script de referencia)
// Atención: este archivo es solo de referencia en formato .kts. El proveedor
// real que se compila y registra en el APK está en:
// android/app/src/main/java/com/mydomain/homescreen_widgets/MiAppWidget.kt

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class MiAppWidget : AppWidgetProvider() {

    companion object {
        const val ACTION_REFRESH = "com.mydomain.homescreen_widgets.ACTION_REFRESH"
    }

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        // Actualiza todos los widgets
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_REFRESH) {
            // Cuando el usuario pulse refrescar, forzamos una actualización
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val thisWidget = ComponentName(context, MiAppWidget::class.java)
            val ids = appWidgetManager.getAppWidgetIds(thisWidget)
            onUpdate(context, appWidgetManager, ids)
        }
    }

}

private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
    // Construye RemoteViews basadas en el layout
    val views = RemoteViews(context.packageName, R.layout.widget_layout)

    // Datos de ejemplo: en un proyecto real leerías desde SharedPreferences, una DB
    // o un servicio de red. Aquí usamos texto estático para simplicidad.
    val title = "Noticias"
    val content = "Resumen rápido: abre la app para leer más."

    views.setTextViewText(R.id.widget_title, title)
    views.setTextViewText(R.id.widget_content, content)

    // Intent para abrir la app cuando se pulse el widget
    val launchIntent = context.packageManager.getLaunchIntentForPackage(context.packageName)
    val pendingLaunch = PendingIntent.getActivity(context, 0, launchIntent, PendingIntent.FLAG_IMMUTABLE)
    views.setOnClickPendingIntent(R.id.widget_root, pendingLaunch)

    // Intent para refrescar cuando se pulse el título (ejemplo)
    val refreshIntent = Intent(context, MiAppWidget::class.java).apply { action = MiAppWidget.ACTION_REFRESH }
    val pendingRefresh = PendingIntent.getBroadcast(context, appWidgetId, refreshIntent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
    views.setOnClickPendingIntent(R.id.widget_title, pendingRefresh)

    // Aplica la actualización
    appWidgetManager.updateAppWidget(appWidgetId, views)
}