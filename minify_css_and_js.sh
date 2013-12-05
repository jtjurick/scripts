# This script aggregates all css and js files for the site, and then minifies each of the resulting files.
# Just fill in {site_name}, {username}, and {password} values at the top of this script
#
# By David Jurick

#!/bin/bash
VAR_SITE={site_name}
VAR_DIR=/pool/www/www.${VAR_SITE}.com/current/
VAR_MAIN=sites/all/themes/${VAR_SITE}/
VAR_TARGET=sites/all/themes/${VAR_SITE}/aggregation/releases/
VAR_CURRENT=sites/all/themes/${VAR_SITE}/aggregation/current
VAR_REMOTE={username}@rsync.bitgravity.com::{username}/../${VAR_SITE}/
VAR_DATE=`date +%H%M%m%d%y`
VAR_MINIFYCSS=/usr/bin/csstidy
VAR_MINIFYJS=/root/jsmin
export RSYNC_PASSWORD={password}

#########################
# Preparation
#########################
echo -n "Creating a timestamped directory, ${VAR_DIR}${VAR_TARGET}${VAR_DATE}, containing the blank aggregate files at "
date
mkdir ${VAR_DIR}${VAR_TARGET}${VAR_DATE}
rm -f ${VAR_DIR}${VAR_CURRENT}
ln -s ${VAR_DIR}${VAR_TARGET}${VAR_DATE} ${VAR_DIR}${VAR_CURRENT}
touch ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
touch ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
touch ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/release.${VAR_DATE}.txt

#########################
# Aggregate all CSS
#########################
echo -n "Concatenating CSS files into all.css at "
date
echo '/*comment.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}modules/comment/comment.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*node.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}modules/node/node.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*admin.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}modules/system/admin.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*defaults.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}modules/system/defaults.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*maintenance.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}modules/system/maintenance.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*system-menus.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}modules/system/system-menus.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*system.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}modules/system/system.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*user.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}modules/user/user.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*admin_menu.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/admin_menu/admin_menu.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*ajax_comments.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/ajax_comments/ajax_comments.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*ajax-form.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/ajax_register/ajax-form.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*thickbox.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/ajax_register/thickbox.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*qunit.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/external/qunit.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.alerts.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/jquery.alerts.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.jcarousel.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/jquery.jcarousel.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.ui.accordion.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/themes/base/jquery.ui.accordion.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.ui.autocomplete.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/themes/base/jquery.ui.autocomplete.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.ui.button.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/themes/base/jquery.ui.button.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.ui.core.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/themes/base/jquery.ui.core.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.ui.datepicker.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/themes/base/jquery.ui.datepicker.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.ui.dialog.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/themes/base/jquery.ui.dialog.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.ui.progressbar.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/themes/base/jquery.ui.progressbar.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.ui.resizable.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/themes/base/jquery.ui.resizable.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.ui.slider.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/themes/base/jquery.ui.slider.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*jquery.ui.theme.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/alertjs/themes/base/jquery.ui.theme.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*comment_notify.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/comment_notify/comment_notify.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*deca_minicart.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/deca_minicart/deca_minicart.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*deca_category_navigation.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/deca_category_navigation/deca_category_navigation.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*deca_experts.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/deca_experts/deca_experts.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*deca_home_page.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/deca_home_page/deca_home_page.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*deca_latest_videos.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/deca_latest_videos/deca_latest_videos.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*deca_rating.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/deca_rating/deca_rating.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*deca_video_poll.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/deca_video_poll/deca_video_poll.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*featured_content.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/featured_content/featured_content.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*lightbox.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/deca/lightbox2/css/lightbox.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*devel.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/devel/devel.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*views.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/modules/views/css/views.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*dropdown.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/themes/${VAR_SITE}/dropdown.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*grid_12-60-20_1.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/themes/${VAR_SITE}/grid_12-60-20_1.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
echo '/*style.css */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
cat ${VAR_DIR}sites/all/themes/${VAR_SITE}/style.css >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css

#########################
# Aggregate all JS
#########################
echo -n "Concatenating JS files into all.js at "
date
echo '/*jquery.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/jquery.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*drupal.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/drupal.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ahah.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/ahah.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*autocomplete.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/autocomplete.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*batch.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/batch.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*collapse.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/collapse.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*form.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/form.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*progress.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/progress.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*tabledrag.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/tabledrag.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*tableheader.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/tableheader.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*tableselect.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/tableselect.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*teaser.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/teaser.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*textarea.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}misc/textarea.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*comment.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}modules/comment/comment.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*system.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}modules/system/system.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery-1.3.2.min.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/jquery-1.3.2.min.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*admin_menu.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/admin_menu/admin_menu.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ajax.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/ajax/ajax.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.a_form.packed.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/ajax/jquery/jquery.a_form.packed.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ajax_disable_redirect.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/ajax/plugins/disable_redirect/ajax_disable_redirect.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ajax_fckeditor.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/ajax/plugins/fckeditor/ajax_fckeditor.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ajax_quicktabs.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/ajax/plugins/quicktabs/ajax_quicktabs.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ajax_thickbox.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/ajax/plugins/thickbox/ajax_thickbox.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ajax_tinymce.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/ajax/plugins/tinymce/ajax_tinymce.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ajax_wysiwyg.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/ajax/plugins/wysiwyg/ajax_wysiwyg.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ajax_comments.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/ajax_comments/ajax_comments.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*init.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/ajax_register/init.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*placeholder.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/ajax_register/placeholder.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*thickbox.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/ajax_register/thickbox.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.bgiframe-2.1.1.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/external/jquery.bgiframe-2.1.1.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.cookie.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/external/jquery.cookie.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.metadata.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/external/jquery.metadata.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*qunit.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/external/qunit.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.alerts.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/jquery.alerts.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.form.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/jquery.form.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.jcarousel.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/jquery.jcarousel.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.draggable.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/jquery.ui.draggable.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery-ui-1.8.1.custom.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery-ui-1.8.1.custom.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.blind.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.blind.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.bounce.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.bounce.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.clip.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.clip.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.core.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.core.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.drop.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.drop.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.explode.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.explode.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.fold.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.fold.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.highlight.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.highlight.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.pulsate.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.pulsate.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.scale.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.scale.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.shake.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.shake.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.slide.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.slide.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.effects.transfer.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.effects.transfer.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.accordion.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.accordion.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.autocomplete.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.autocomplete.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.button.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.button.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.core.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.core.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.datepicker.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.datepicker.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.dialog.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.dialog.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.draggable.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.draggable.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.droppable.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.droppable.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.mouse.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.mouse.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.position.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.position.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.progressbar.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.progressbar.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.resizable.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.resizable.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.selectable.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.selectable.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.slider.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.slider.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.sortable.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.sortable.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.tabs.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.tabs.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*jquery.ui.widget.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/alertjs/ui/jquery.ui.widget.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*comment_notify.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/comment_notify/comment_notify.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_category_navigation.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_category_navigation/deca_category_navigation.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*base64.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_comments/base64.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_comment_f.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_comments/deca_comment_f.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*loader.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_comments/loader.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*swfobject.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_comments/swfobject.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*youtube.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_comments/youtube.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_content_category.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_content_category/deca_content_category.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_content_related.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_content_related/deca_content_related.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_content_related_y.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_content_related/deca_content_related_y.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_content_series_pages.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_content_series/deca_content_series_pages.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_content_subcategory.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_content_subcategory/deca_content_subcategory.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_content_text_pages.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_content_text/deca_content_text_pages.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_content_video_comment.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_content_video/deca_content_video_comment.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_content_video_home_pages.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_content_video/deca_content_video_home_pages.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_content_video_pages.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_content_video/deca_content_video_pages.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_email_verify.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_email_verify/deca_email_verify.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_experts.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_experts/deca_experts.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*favorite_nodes.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_favorite_nodes/favorite_nodes.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_fbconnect.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_fbconnect/deca_fbconnect.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_findology.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_findology/deca_findology.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_home_page.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_home_page/deca_home_page.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_latest_videos.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_latest_videos/deca_latest_videos.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_profile_user_pages.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_profile_user/deca_profile_user_pages.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_rating.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_rating/deca_rating.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_skybox.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_skybox/deca_skybox.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*init.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_tracker/init.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*deca_video_poll.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/deca_video_poll/deca_video_poll.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*latest_videos.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/latest_videos/js/latest_videos.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*lightbox.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/lightbox2/js/lightbox.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*subscriptions_links.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/subscriptions/subscriptions_links.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*subscriptions_tableselect.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/deca/subscriptions/subscriptions_tableselect.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ui.draggable.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/devel/ui.draggable.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*ui.mouse.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/modules/devel/ui.mouse.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
echo '/*swfobject.js */' >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
cat ${VAR_DIR}sites/all/themes/${VAR_SITE}/swfobject.js >> ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js

#########################
# Minify
#########################
echo -n "Minifying the aggregate files at "
date
mv ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.full.css
mv ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.full.js
${VAR_MINIFYCSS} ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.full.css ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.css
${VAR_MINIFYJS} <${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.full.js > ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.js
rm -rf ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.full.*

#########################
# Upload aggregates to BitGravity
#########################
echo "Rsyncing the aggregate files, including their timestamped directory, ${VAR_DATE}, to their respective site folder on the CDN at "
date
rsync -rtlv ${VAR_DIR}${VAR_TARGET}${VAR_DATE} ${VAR_REMOTE}${VAR_TARGET}
rsync -rtlv --delete ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/* ${VAR_REMOTE}${VAR_CURRENT}/
rsync -rtlv --delete ${VAR_DIR}${VAR_TARGET}${VAR_DATE}/all.* ${VAR_REMOTE}${VAR_MAIN}
echo "Finished syncing the aggregate files from their local to remote directory "
date
