package com.liferay.mobile.screens.asset.list.interactor;

import com.liferay.mobile.screens.asset.list.AssetEntry;
import com.liferay.mobile.screens.blogs.BlogsEntry;
import com.liferay.mobile.screens.context.User;
import com.liferay.mobile.screens.ddl.model.Record;
import com.liferay.mobile.screens.dlfile.display.FileEntry;
import com.liferay.mobile.screens.util.LiferayLocale;
import com.liferay.mobile.screens.webcontent.WebContent;
import java.util.Locale;
import java.util.Map;

/**
 * @author Javier Gamarra
 */
public class AssetFactory {

	private AssetFactory() {
		super();
	}

	public static AssetEntry createInstance(Map<String, Object> map) {

		if (map.containsKey("object")) {
			map.putAll((Map) map.get("object"));

			String stringLocale = (String) map.get("locale");
			String className = (String) map.get("className");

			if (stringLocale != null) {
				Locale locale = LiferayLocale.getLocaleWithoutDefault(stringLocale);

				if (className.endsWith("JournalArticle")) {
					return new WebContent(map, locale);
				} else if (className.endsWith("DDLRecord")) {
					return new Record(map, locale);
				} else if (className.endsWith("DLFileEntry")) {
					return new FileEntry(map);
				} else if (className.endsWith("BlogsEntry")) {
					return new BlogsEntry(map);
				} else if (className.endsWith("User")) {
					return new User(map);
				}
			}
		}
		return new AssetEntry(map);
	}
}
