/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.language = 'zh-cn';
	config.filebrowserBrowseUrl = getRootPath()+'/js/ckeditor/uploader/browse.jsp';
	config.filebrowserImageBrowseUrl = getRootPath()+'/js/ckeditor/uploader/browse.jsp?type=Images';
	config.filebrowserFlashBrowseUrl = getRootPath()+'/js/ckeditor/uploader/browse.jsp?type=Flashs';
	config.filebrowserUploadUrl = getRootPath()+'/js/ckeditor/uploader/upload.jsp';
	config.filebrowserImageUploadUrl = getRootPath()+'/js/ckeditor/uploader/upload.jsp?type=Images';
	config.filebrowserFlashUploadUrl = getRootPath()+'/js/ckeditor/uploader/upload.jsp?type=Flashs';
	config.filebrowserWindowWidth = '640';
	config.filebrowserWindowHeight = '480';
	config.width = 800;
	config.height = 400;
	config.toolbar_A =
		[
			['Source'],
			['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
			['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
			'/',
			['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
			['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
			['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
			['Link','Unlink','Anchor'],
			['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
			'/',
			['Styles','Format','Font','FontSize'],
			['TextColor','BGColor'],
			['Maximize', 'ShowBlocks']
		];
	config.toolbar = 'A';
};
