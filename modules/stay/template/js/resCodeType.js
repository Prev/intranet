/*
	SUCC - success
	ERR - error
*/
const SUCC_UPDATE_STAY_DATA				=	1001 // 잔류 학생 정보 수정 성공
const SUCC_ADD_STAY_DATA				=	1002 // 잔류 학생 정보 추가 성공
const SUCC_DELETE_STAY_DATA				=	1003 // 잔류 학생 정보 삭제 성공

const ERR_NO_STUDENT					=	9001 // 해당 학생의 정보가 존재하지 않음
const ERR_NO_STAY_DATE					=	9002 // 잔류일자가 존재하지 않음
const ERR_FAIL_UPDATE_STAY_DATA			=	9003 // 잔류 학생 정보 수정 실패
const ERR_FAIL_ADD_STAY_DATA			=	9004 // 잔류 학생 정보 추가 실패
const ERR_GOINGOUT_START_TIME_IS_FASTER_THAN_END_TIME	= 9005 // 외출 시작 시간이 외출 종료 시간보다 늦음
const ERR_NO_STAY_STUDENT				=	9006 // 해당 학생은 잔류하는 학생이 아님
const ERR_FAIL_DELETE_STAY_DATA			=	9007 // 잔류 학생 정보 삭제 실패