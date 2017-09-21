<%@ page language="java" import="java.util.*,com.clubmanage.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Users um = (Users) session.getAttribute("userKey");
Activity acc = (Activity) session.getAttribute("activitysTranKey");
List<Comment> co = (List<Comment>) session.getAttribute("commentKey");
%>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="utf-8">
    <style type="text/css">
        body { font-size: 12px; line-height: 120%; text-align: center; color:#333; padding: 20px;}
        a { color: #333; text-decoration: none;}
        a:hover { text-decoration: underline;}
        * { margin: 0; padding: 0; border: none;}
        .clearfix:after { content:"."; display:block; height:0; clear:both; visibility:hidden}
        .clearfix { *height:1%;}
        #list { margin: 0 auto; text-align: left; width: 540px;}
        .box { border-top: 1px solid #eee; position: relative;  width: 540px; padding: 20px 0}
        .box:hover .close { display: block;}
        .close { display: none; top:0px; right: 0px; width: 28px; height: 28px; border: 1px solid #eee; position: absolute; background: #f2f4f7; line-height: 27px; text-align: center;}
        .close:hover { background: #c8d2e2; text-decoration: none;}
        .head { float: left; width: 60px; height: 60px; margin-right: 10px;}
        .content { float: left; width: 440px;}
        .main { margin-bottom: 10px;}
        .txt { margin-bottom: 10px;}
        .user { color: #369; }
        .pic { margin-right: 5px; width: 200px; border: 1px solid #eee;}
        .info { height: 20px; line-height: 19px; font-size: 12px; margin: 0 0 10px 0;}
        .info .time { color: #ccc; float: left; height: 20px; padding-left: 20px; background: url("images/bg1.jpg") no-repeat left top;}
        .info .praise { color: #369; float: right; height: 20px; padding-left: 18px; background: url("images/bg2.jpg") no-repeat left top;}
        .info .praise:hover { text-decoration: underline; background: url("images/bg3.jpg") no-repeat left top;}
        .praises-total { margin: 0 0 10px 0; height: 20px; background: url("images/praise.png") no-repeat 5px 5px rgb(247, 247, 247); padding: 5px 0 5px 25px; line-height: 19px;}
        .comment-box { padding: 10px 0; border-top: 1px solid #eee;}
        .comment-box:hover { background: rgb(247, 247, 247);}
        .comment-box .myhead { float: left; width: 30px; height: 30px; margin-right: 10px;}
        .comment-box .comment-content { float: left; width: 400px; }
        .comment-box .comment-content .comment-time { color: #ccc; margin-top: 3px; line-height: 16px; position: relative;}
        .comment-box .comment-content .comment-praise { display: none; color: #369; padding-left: 17px; height: 20px; background: url("images/praise.png") no-repeat;  position: absolute; bottom: 0px; right: 44px;}
        .comment-box .comment-content .comment-operate { display: none; color: #369; height: 20px;  position: absolute; bottom: 0px; right: 10px;}
        .comment-box .comment-content:hover .comment-praise { display: inline-block;}
        .comment-box .comment-content:hover .comment-operate { display: inline-block;}
        .text-box .comment { border: 1px solid #eee; display: block; height: 15px; width: 428px; padding: 5px; resize: none; color: #ccc}
        .text-box .btn { font-size: 12px; font-weight: bold; display: none; float: right; width: 65px; height: 25px; border: 1px solid #0C528D; color: #fff; background: #4679AC;}
        .text-box .btn-off { border: 1px solid #ccc; color: #ccc; background: #F7F7F7;}
        .text-box .word{ display: none; float: right; margin: 7px 10px 0 0; color: #666;}
        .text-box-on .comment{ height: 50px; color: #333;}
        .text-box-on .btn{ display: inline;}
        .text-box-on .word{ display: inline;}
    </style>
    <script type="text/javascript" src="js/demo.js"></script>
</head>
<body>
    <div id="list">
        <div class="box clearfix">
            <a class="close" href="javascript:;">×</a>
            <div class="content">
                <div class="info clearfix">
                    <span class="time">02-14 23:01</span>
                    <a class="praise" href="javascript:;">赞</a>
                </div>
                <div class="praises-total" total="4" style="display: block;">4个人觉得很赞</div>
                <%
                	for(int i=0;i < co.size();i++)
                	{
                		Comment c = co.get(i);
                		if(c.getZan().equals("0"))
                		{
                %>
                <div class="comment-list">
                    <div class="comment-box clearfix" user="self">
                        <img class="myhead" src="images/my.jpg" alt=""/>
                        <div class="comment-content">
                            <p class="comment-text"><span class="user"><%=c.getPinglunzhe() %>：</span><%=c.getNeirong() %></p>
                            <p class="comment-time">
                                2017-06-09 08:20
                                <a href="javascript:;" class="comment-praise" total="1" my="0" style="display: inline-block">赞</a>
                                <a href="commentUpdate.action?commentId=<%=c.getId().getCommentId() %>&activityId=<%=c.getId().getActivityId() %>&zan=1&pinglunzhe=<%=c.getPinglunzhe() %>&jieshoufang=<%=c.getJieshoufang() %>&plneirong=<%=c.getPlneirong() %>&shijian=<%=c.getShijian() %>&neirong=<%=c.getNeirong() %>" class="comment-operate">举报</a>
                            </p>
                        </div>
                    </div>
                </div>
                <%}	}%>
                <form action="commentCreate.action" method="post">
                <div class="text-box">
                    <input name="activityId" type="text" style="display:none" value="<%=acc.getActivityId() %>">
                    <input name="commentId" type="text" style="display:none" value="<%=co.size()+1 %>">
                    <input name="pinglunzhe" type="text" style="display:none" value="<%=um.getName() %>">
                    <input name="jieshoufang" type="text" style="display:none" value="活动创始者">
                    <input name="plneirong" type="text" style="display:none" value="无">
                    <input name="shijian" type="text" style="display:none" value="2017-06-09 08:20">
                    <textarea name="neirong" class="comment" autocomplete="off">评论…</textarea>
                    <input name="zan" type="text" style="display:none" value="0">
                    <button type="submit" class="btn ">回 复</button>
                    <span class="word"><span class="length">0</span>/140</span>
                </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>