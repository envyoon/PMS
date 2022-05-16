<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>공지사항 상세</title>

<!-- Custom fonts for this template-->
<link href="${path}/pms_test/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
    href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
    rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/pms_test/css/sb-admin-2.min.css" rel="stylesheet">

<!-- -->
	<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
	<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
	<script src="${path}/a00_com/jquery.min.js"></script>
	<script src="${path}/a00_com/popper.min.js"></script>
	<script src="${path}/a00_com/bootstrap.min.js"></script>
	<script src="${path}/a00_com/jquery-ui.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
 
 


</head>

<script type="text/javascript">
	$(document).ready(function(){
		var msg = "${msg}";
		if(msg!=""){
			if(msg=="수정되었습니다"){
				if(confirm(msg+"\n조회화면이동하시겠습니까?")){
					location.href="${path}/notice.do?method=list";
				}	
			}
			if(msg=="삭제되었습니다."){
			
				alert(msg+"\n조회화면으로 이동")
				location.href="${path}/notice.do?method=list";
			}
		}
		<%-- 
		
		--%>
		$("#goMain").click(function(){
			location.href="${path}/notice.do?method=list";
		});
		// 삭제버튼 클릭시, session으로 수정권한 확인 해서(작성자와 동일)
		// 권한이 있는 경우에만 삭제 처리..
		$("#delBtn").click(function(){
			if(sessId!=$("[name=writer]").val()){
				alert("삭제는 작성자만 가능합니다.")
			}else{
				if(confirm("삭제하시겠습니까?")){
					location.href="${path}/notice.do?method=del&notice_list_num="+$("[name=notice_list_num]").val();	
				}
			}
		});
		$("#uptBtn").click(function(){
			if(sessId!=$("[name=writer]").val()){
				alert("수정은 작성자만 가능합니다!");
			}else{
				if(confirm("수정하시겠습니까?")){
					$("form").attr("action","${path}/notice.do?method=upt");
					$("form").submit();
				}
			}
		});
		$("#reBtn").click(function(){
			if(confirm("답글을 작성하시겠습니까?")){
				// 등록 form에 기본적인 답글 형식을 만들어서 요청값으로 전송하여,
				// 등록 form에서 추가 데이터를 입력하여 처리하게 한다.
				$("[name=notice_refno]").val($("[name=notice_list_num]").val());
				$("[name=notice_title]").val("RE:"+$("[name=notice_title]").val());
				$("[name=notice_content]").val("\n\n\n\n\n\n\======이전글======\n"+$("[name=notice_content]").val());
				$("form").attr("action","${path}/notice.do?method=insertFrm");
				$("form").submit();
			}
		});
		
	});
	function downFile(fname){
		if(confirm("다운로드할 파일:"+fname)){
			location.href="${path}/download.do?fname="+fname;
		}
	}
</script>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${path}/main.do">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-solid fa-database"></i>
                </div> 
                <div class="sidebar-brand-text mx-3">"YY PMS"</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="${path}/main.do">
                    <i class="fas fa-fw  fa-users"></i>
                    <span>${member.dname}</span></a>
                <a class="nav-link" href="${path}/mypage.do">
                    <i class="fas fa-fw  fa-user"></i>
                    <span>${member.name}</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                MEMBER
            </div>

				
			<!-- 대시보드 -->
			<li class="nav-item">
                <a class="nav-link" href="${path}/main.do">
                    <i class="fas fa-fw fa-clipboard-check"></i>
                    <span>Dashboard</span></a>
            </li>	
			
			<!-- 업무보기 -->
			<li class="nav-item">
				<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-list"></i>
                    <span>My job</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">View</h6>
                        <a class="collapse-item" href="${path}/myjobList.do">업무보기</a>
                        <a class="collapse-item" href="${path}/projectList.do">Project</a>
                        <a class="collapse-item" href="${path}/gantt.do">Gantt Chart</a>
                        <a class="collapse-item" href="${path}/calendar.do">Calendar</a>
                    </div>
                </div>
            </li>
				
			
	
			<!-- 커뮤니케이션 -->
			<li class="nav-item">
				<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-comment"></i>
                    <span>Communicate</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">View</h6>
                        <a class="collapse-item" href="${path}/notice.do">Notice</a>
                        <a class="collapse-item" href="${path}/communicate.do">Chatting</a>
                    </div>
                </div>
            </li>
            
            <!-- 문서탭 -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-file"></i>
                    <span>Documents</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">View</h6>
                        <a class="collapse-item" href="${path}/meetingList.do">Meeting</a>
                        <a class="collapse-item" href="${path}/workList.do">Work</a>
                        <a class="collapse-item" href="${path}/outputList.do">Outputs</a>
                    </div>
                </div>
            </li>

			<!-- 내정보 -->
			<li class="nav-item">
                <a class="nav-link" href="${path}/mypage.do">
                    <i class="fas fa-fw fa-list"></i>
                    <span>My Info</span></a>
            </li>           

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                ADMIN
            </div>


            <!-- 회원관리 -->
            <li class="nav-item">
                <a class="nav-link" href="${path}/memberList.do">
                    <i class="fas fa-fw fa-list"></i>
                    <span>MemberList</span></a>
            </li>


            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

           
			
        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Search -->
                    <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    Alerts Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 12, 2019</div>
                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 7, 2019</div>
                                        $290.29 has been deposited into your account!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 2, 2019</div>
                                        Spending Alert: We've noticed unusually high spending for your account.
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                            </div>
                        </li>

                        <!-- Nav Item - Messages -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-envelope fa-fw"></i>
                                <!-- Counter - Messages -->
                                <span class="badge badge-danger badge-counter">7</span>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="messagesDropdown">
                                <h6 class="dropdown-header">
                                    Message Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="${path}/pms_test/img/undraw_profile_1.svg"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">Hi there! I am wondering if you can help me with a
                                            problem I've been having.</div>
                                        <div class="small text-gray-500">Emily Fowler · 58m</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="${path}/pms_test/img/undraw_profile_2.svg"
                                            alt="...">
                                        <div class="status-indicator"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">I have the photos that you ordered last month, how
                                            would you like them sent to you?</div>
                                        <div class="small text-gray-500">Jae Chun · 1d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="${path}/pms_test/img/undraw_profile_3.svg"
                                            alt="...">
                                        <div class="status-indicator bg-warning"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Last month's report looks great, I am very happy with
                                            the progress so far, keep up the good work!</div>
                                        <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Am I a good boy? The reason I ask is because someone
                                            told me that people say this to all dogs, even if they aren't good...</div>
                                        <div class="small text-gray-500">Chicken the Dog · 2w</div>
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                            </div>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${member.name} 님</span>
                                <img class="img-profile rounded-circle"
                                    src="${path}/pms_test/img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800"></h1>
                    </div>

            <!-- Content Row -->

<div class="container">
	<form method="post" enctype="multipart/form-data"
		action="${path}/notice.do?method=upt">
		
	<div class="input-group mb-3 fileCls">	
		<div class="input-group-prepend">
			<span class="input-group-text">프로젝트명</span>
		</div>
			<input name="project_name" class="form-control" value="${notice.project_name}"
					placeholder="작성자입력하세요" readonly /> 
		<div class="input-group-prepend">
			<span class="input-group-text">부서명</span>
		</div>
			<input name="dname" class="form-control" value="${notice.dname}" readonly/>	
	</div>											
	<div class="input-group mb-3 fileCls">	
			<div class="input-group-prepend">
				<span class="input-group-text">작 성 자</span>
			</div>
			<input name="writer" class="form-control" 
				placeholder="작성자입력하세요"   value="${member.name}" readonly/>
			<!-- 작성자는 입력해서 변경불가능 처리 -->	
			<div class="input-group-prepend">
				<span class="input-group-text">조회수</span>
			</div>
			<input name="readcnt" class="form-control" value="${notice.readcnt}" readonly/>	
	</div>			
	<div class="input-group mb-3 fileCls">	
		<div class="input-group-prepend">
			<span class="input-group-text">글번호</span>
		</div>
		<input name="notice_list_num" class="form-control" value="${notice.notice_list_num}" readonly/>	
		<div class="input-group-prepend">
			<span class="input-group-text">상위글번호</span>
		</div>
		<input name="notice_refno" class="form-control" value="${notice.notice_refno}" readonly/>	
	</div>			
		
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text">제 목</span>
		</div>
		<input name="notice_title" class="form-control" value="${notice.notice_title}" />			 
	</div>  
	
	<div class="input-group mb-3 fileCls">	
		<div class="input-group-prepend">
			<span class="input-group-text">등 록 일</span>
		</div>
		
		<input class="form-control" 
			placeholder="작성자입력하세요"  readonly
			value='<fmt:formatDate type="both" value="${notice.notice_reg}"  />'/>	
		<div class="input-group-prepend">
			<span class="input-group-text">수 정일</span>
		</div>
		<input  class="form-control" readonly
			value='<fmt:formatDate type="both" value="${notice.notice_upt}" />'/>	
	</div>			
	<div class="input-group mb-3 fileCls">
		<div class="input-group-prepend">
			<span class="input-group-text">내 용</span>
		</div>
		<textarea name="notice_content" rows="10" 
			class="form-control" 
			placeholder="내용입력하세요" >${notice.notice_content}</textarea>		 
	</div> 
	<c:forEach var="fname" items="${board.fnames}">
	<div class="input-group mb-3 fileCls">
		<div class="input-group-prepend">
			<span class="input-group-text" 
				onclick="downFile('${fname}')">첨부 파일(다운로드)</span>
		</div>
		<div class="custom-file">
			<input type="file" name="report" 
				class="custom-file-input" id="file01"/>
			<label class="custom-file-label" for="file01">${fname}</label>
		</div>		
	</div> 	 
	</c:forEach>
 	</form>
 	<div style="text-align:right;">
 		<input type="button" class="btn btn-primary"
			value="답글" id="reBtn"/>	
		<input type="button" class="btn btn-warning"
			value="수정" id="uptBtn"/>
		<input type="button" class="btn btn-danger"
			value="삭제" id="delBtn"/>			
		<input type="button" class="btn btn-success"
			value="조회 화면으로" id="goMain"/>
	</div>	
</div>
</div>

            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Author KIM YUNA and Author HEO YOONSEOK</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="${path}/pms_test/vendor/jquery/jquery.min.js"></script>
    <script src="${path}/pms_test/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${path}/pms_test/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${path}/pms_test/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="${path}/pms_test/vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="${path}/pms_test/js/demo/chart-area-demo.js"></script>
    <script src="${path}/pms_test/js/demo/chart-pie-demo.js"></script>
    <style type="text/css">
	.input-group-text{width:100%;background-color:dark;color:black;font-weight:bolder;}
	.input-group-prepend{width:20%;}
	td{text-align:center;}
	</style>

</body>
</html>