// meetList 더미 데이터

// 최종 수정: 2023.6.2
// 작업자: 정해수

import 'package:front/data/meetList.dart';
import 'meet.dart';

//List 클래스 더미 객체
meet test0 = meet(meetNo: 0, categoryName: "스터디",time: DateTime.parse("2023-07-30 15:00:00"),
    title: "스터디 모임 모집합니다", userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: null, commentNum: 2, peopleLimit: 5, peopleNum: 3, lat: 35.886714, lon: 128.222,
    personClosed: false, fee: 5000, content: "스터디 내용 등등", approval: false,
    timeClosed: false, hostUser: {"userNo": 1, "userProfileImage": "image", "username": "test"},
    comments: [{"meetCommentNo": 4, "meetNo": 5, "parentNo": null, "content": "comment 2",
      "userNo": 2, "userProfileImage": null, "username": "b", "createDate": "2023-05-31 04:02:42"},
      {"meetCommentNo": 3, "meetNo": 5, "parentNo": null, "content": "comment test", "userNo": 1,
        "userProfileImage": "image", "username": "test", "createDate": "2023-05-31 04:02:35"}],
    userList: [{"userNo": 1, "userProfileImage": "image", "username": "test"},{"userNo": 2,
      "userProfileImage": null, "username": "b"}], isInsert: false, age: "전연령");

meet test1 = meet(meetNo: 1, categoryName: "게임",time: DateTime.parse("2023-06-30 19:00:00"),
    title: "test3", userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: null, commentNum: 2, peopleLimit: 2, peopleNum: 5, lat: 35.886714, lon: 128.222,
    personClosed: false, fee: 5000, content: "2공원에서 함께 축구를 즐길 모임입니다.", approval: false,
    timeClosed: false, hostUser: {"userNo": 1, "userProfileImage": "image", "username": "test"},
    comments: [{"meetCommentNo": 4, "meetNo": 5, "parentNo": null, "content": "comment 2",
      "userNo": 2, "userProfileImage": null, "username": "b", "createDate": "2023-05-31 04:02:42"},
      {"meetCommentNo": 3, "meetNo": 5, "parentNo": null, "content": "comment test", "userNo": 1,
        "userProfileImage": "image", "username": "test", "createDate": "2023-05-31 04:02:35"}],
    userList: [{"userNo": 1, "userProfileImage": "image", "username": "test"},{"userNo": 2,
      "userProfileImage": null, "username": "b"}], isInsert: false, age: "전연령");

meet test2 = meet(meetNo: 2, categoryName: "게임",time: DateTime.parse("2023-06-30 19:00:00"),
    title: "test3", userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: null, commentNum: 2, peopleLimit: 2, peopleNum: 5, lat: 35.886714, lon: 128.222,
    personClosed: false, fee: 5000, content: "2공원에서 함께 축구를 즐길 모임입니다.", approval: false,
    timeClosed: false, hostUser: {"userNo": 1, "userProfileImage": "image", "username": "test"},
    comments: [{"meetCommentNo": 4, "meetNo": 5, "parentNo": null, "content": "comment 2",
      "userNo": 2, "userProfileImage": null, "username": "b", "createDate": "2023-05-31 04:02:42"},
      {"meetCommentNo": 3, "meetNo": 5, "parentNo": null, "content": "comment test", "userNo": 1,
        "userProfileImage": "image", "username": "test", "createDate": "2023-05-31 04:02:35"}],
    userList: [{"userNo": 1, "userProfileImage": "image", "username": "test"},{"userNo": 2,
      "userProfileImage": null, "username": "b"}], isInsert: false, age: "전연령");

meet test3 = meet(meetNo: 3, categoryName: "게임",time: DateTime.parse("2023-06-30 19:00:00"),
    title: "test3", userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: null, commentNum: 2, peopleLimit: 2, peopleNum: 5, lat: 35.886714, lon: 128.222,
    personClosed: false, fee: 5000, content: "2공원에서 함께 축구를 즐길 모임입니다.", approval: false,
    timeClosed: false, hostUser: {"userNo": 1, "userProfileImage": "image", "username": "test"},
    comments: [{"meetCommentNo": 4, "meetNo": 5, "parentNo": null, "content": "comment 2",
      "userNo": 2, "userProfileImage": null, "username": "b", "createDate": "2023-05-31 04:02:42"},
      {"meetCommentNo": 3, "meetNo": 5, "parentNo": null, "content": "comment test", "userNo": 1,
        "userProfileImage": "image", "username": "test", "createDate": "2023-05-31 04:02:35"}],
    userList: [{"userNo": 1, "userProfileImage": "image", "username": "test"},{"userNo": 2,
      "userProfileImage": null, "username": "b"}], isInsert: false, age: "전연령");

meet test4 = meet(meetNo: 4, categoryName: "게임",time: DateTime.parse("2023-06-30 19:00:00"),
    title: "test3", userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: null, commentNum: 2, peopleLimit: 2, peopleNum: 5, lat: 35.886714, lon: 128.222,
    personClosed: false, fee: 5000, content: "2공원에서 함께 축구를 즐길 모임입니다.", approval: false,
    timeClosed: false, hostUser: {"userNo": 1, "userProfileImage": "image", "username": "test"},
    comments: [{"meetCommentNo": 4, "meetNo": 5, "parentNo": null, "content": "comment 2",
      "userNo": 2, "userProfileImage": null, "username": "b", "createDate": "2023-05-31 04:02:42"},
      {"meetCommentNo": 3, "meetNo": 5, "parentNo": null, "content": "comment test", "userNo": 1,
        "userProfileImage": "image", "username": "test", "createDate": "2023-05-31 04:02:35"}],
    userList: [{"userNo": 1, "userProfileImage": "image", "username": "test"},{"userNo": 2,
      "userProfileImage": null, "username": "b"}], isInsert: false, age: "전연령");

meet test5 = meet(meetNo: 5, categoryName: "게임",time: DateTime.parse("2023-06-30 19:00:00"),
    title: "test3", userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: null, commentNum: 2, peopleLimit: 2, peopleNum: 5, lat: 35.886714, lon: 128.222,
    personClosed: false, fee: 5000, content: "2공원에서 함께 축구를 즐길 모임입니다.", approval: false,
    timeClosed: false, hostUser: {"userNo": 1, "userProfileImage": "image", "username": "test"},
    comments: [{"meetCommentNo": 4, "meetNo": 5, "parentNo": null, "content": "comment 2",
      "userNo": 2, "userProfileImage": null, "username": "b", "createDate": "2023-05-31 04:02:42"},
      {"meetCommentNo": 3, "meetNo": 5, "parentNo": null, "content": "comment test", "userNo": 1,
        "userProfileImage": "image", "username": "test", "createDate": "2023-05-31 04:02:35"}],
    userList: [{"userNo": 1, "userProfileImage": "image", "username": "test"},{"userNo": 2,
      "userProfileImage": null, "username": "b"}], isInsert: false, age: "전연령");

meetList testList0 = meetList(categoryName: "스터디",time: DateTime.parse("2023-07-30 15:00:00"),
    title: "스터디 모임 모집합니다", meetNo: 0, userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: "", commentNum: 2, peopleLimit: 6, peopleNum: 1, lat: 35.886714, lon: 128.222,
    peopleClosed: false);

meetList testList1 = meetList(categoryName: "게임",time: DateTime.parse("2023-06-30 19:00:00"),
    title: "test3", meetNo: 1, userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: "", commentNum: 2, peopleLimit: 6, peopleNum: 2, lat: 35.886714, lon: 128.222,
    peopleClosed: false);

meetList testList2 = meetList(meetNo: 2, categoryName: "게임",time: DateTime.parse("2023-06-30 19:00:00"),
    title: "test3", userNo: 2, userProfileImage: "image", username: "test", address: "대구",
    meetImage: "", commentNum: 2, peopleLimit: 8, peopleNum: 5, lat: 35.886714, lon: 128.222,
    peopleClosed: false);

meetList testList3 = meetList(categoryName: "게임",time: DateTime.parse("2023-06-30 19:00:00"),
    title: "test3", meetNo: 3, userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: "", commentNum: 2, peopleLimit: 8, peopleNum: 7, lat: 35.886714, lon: 128.222,
    peopleClosed: false);

meetList testList4 = meetList(categoryName: "게임",time: DateTime.parse("2023-06-30 19:00:00"),
    title: "test3",meetNo: 4, userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: "", commentNum: 2, peopleLimit: 12, peopleNum: 2, lat: 35.886714, lon: 128.222,
    peopleClosed: false);

meetList testList5 = meetList(categoryName: "게임",time: DateTime.parse("2023-06-30 19:00:00"),
    title: "test3", meetNo: 5, userNo: 1, userProfileImage: "image", username: "test", address: "대구",
    meetImage: "", commentNum: 2, peopleLimit: 4, peopleNum: 3, lat: 35.886714, lon: 128.222,
    peopleClosed: false);

//리스트 더미
List<meetList> initList = [testList0, testList1, testList2, testList3, testList4, testList5];
List<meetList> addList = [testList5, testList4, testList3, testList2, testList1, testList0];

//유저 정보 더미
Map tempUser = {"userNo": 0, "userProfileImage": "Image", "username": "User"};