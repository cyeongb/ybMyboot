package com.google.ybMyboot.common.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.content.tagrules.html.DivExtractingTagRuleBundle;

public class MySiteMeshFilter extends ConfigurableSiteMeshFilter  {

	@Override
	   protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {

		// Map default decorator. This shall be applied to all paths if no other paths match.
		      builder.addDecoratorPath("/*", "/WEB-INF/jsp/decorator/decorator.jsp")
//		           .addDecoratorPaths("/articles/*", "/decorators/article.html",
//		                                             "/decoratos/two-page-layout.html",
//		                                             "/decorators/common.html")
		            // Exclude path from decoration.
		            .addExcludedPath("/member/list.do")
		            .addExcludedPath("/base/codeWindow.html*")
		            .addExcludedPath("/base/postWindow.html*");
		 
		      builder.addTagRuleBundles(new DivExtractingTagRuleBundle());

	   }
}
