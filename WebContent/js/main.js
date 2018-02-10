$().ready(function() {
	$("#login_form").validate({
		rules: {
			username: {
				required: true,
				Uname: true
			},
			password: {
				required: true,
				minlength: 5
			},
		},
		messages: {
			username: {
				required: "请输入姓名",
				Uname: "请输入英文字母开头的5-10位字符串，例如a123456789"
			},
			password: {
				required: "请输入密码",
				minlength: jQuery.format("密码不能小于{0}个字 符")
			},
		}
	});
	$("#register_form").validate({
		rules: {
			username: {
				required: true,
				Uname: true
			},
			password: {
				required: true,
				minlength: 5
			},
			rpassword: {
				equalTo: "#register_password"
			},
			email: {
				required: true,
				email: true
			}
		},
		messages: {
			username: {
				required: "请输入姓名",
				Uname: "请输入英文字母开头的5-10位字符串，例如a123456789"
			},
			password: {
				required: "请输入密码",
				minlength: jQuery.format("密码不能小于{0}个字 符")
			},
			rpassword: {
				equalTo: "两次密码不一样"
			},
			email: {
				required: "请输入邮箱",
				email: "请输入有效邮箱"
			}
		}
	});
	$("#reply_form").validate({
		rules: {
			title: {
				required: true,
				maxlength:20
			},
			cont: {
				required: true,
				maxlength: 300
			},
		},
		messages: {
			title: {
				required: "请输入标题",
				maxlength: jQuery.format("标题不能超过{0}个字 符")
			},
			cont: {
				required: "请输入内容",
				maxlength: jQuery.format("内容不能超过{0}个字 符")
			},
		}
	});
});
$(function() {
	$("#register_btn").click(function() {
		$("#register_form").css("display", "block");
		$("#login_form").css("display", "none");
	});
	$("#back_btn").click(function() {
		$("#register_form").css("display", "none");
		$("#login_form").css("display", "block");
	});
});