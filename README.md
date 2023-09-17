# To-Do List App - KangmoonSeo
To-Do List App using Flutter

URL : https://kangmoonseo.github.io/web/todolist/



---
## 구현 기능 정리 (Day 1 ~ Day 6)
- 기본 기능
    - To-do 추가
    - To-do 삭제
    - To-do 완료 여부, 중요 표시
    - 상태에 따른 To-do 분류
- 추가 기능
    - 사용자에게 상호작용 메시지 전달
        - 사용자와 앱의 상호작용 내용을 하단 메시지로 전달합니다. 
    - To-do 편집
        - To-do를 길게 눌러 수정이 가능합니다.
    - Undo : To-do 복원
        - To-do를 삭제했을 때 메시지의 Undo 버튼을 누르면 삭제한 To-do가 복원됩니다. 
    - 설정 버튼
        - 데이터 백업 
            - 백업 코드가 되는 긴 문자열을 사용자에게 전달합니다. 
        - 데이터 복원
            - 백업 코드를 붙여넣으면 To-do 데이터가 복원됩니다. 
            - 양식에 맞지 않는 코드를 사용자가 입력하면 잘못된 코드임을 알려줍니다. 
        - 데이터 초기화
---
## Day 1

### 구현 내용

- 기본 UI 설계 
- To-do 추가 

--- 
- 현재 HomeScreen이 AddTodo와 TodoList를 자식으로 가지고 있는 상황입니다.
-  이때 AddTodo Widget에서 변경한 데이터를 TodoList Widget로 넘기기 위해 두 가지 방법을 고려하고 있습니다. 
    1. 상태 관리 라이브러리를 사용 (GetX 등)
    2. HomeScreen을 Stateful로 만들어 HomeScreen build 관련 메서드를 AddTodo에게 전달
- Day 2 에서 두 방법 중 하나를 선택해 기능을 완성하겠습니다.

---
## Day 2

<details>
<summary>이미지 접기/펼치기</summary>

### To-Do 생성 UI 개선
![To-Do 생성 UI 개선](images/AddTodo.gif)

### Important 토글
![Important 토글](images/ToggleImportant.gif)

### Completed 토글
![Completed 토글](images/ToggleCompleted.gif)

## 텍스트 수정
![텍스트 수정](images/EditText.gif)

## To-Do 삭제
![To-Do 삭제](images/DeleteTodo.gif)
</details>


### 구현 내용

- 상태 관리 문제 해결 
    - AddTodo 위젯 -> 메서드화, HomeScreen 위젯과 통합
    - `List<int> todoList`, `List<TodoModel> todoRepository` 이분화
        - todoRepository에서 각각의 TodoModel을 저장
        - 리스트를 다룰 때에는 todoList 
- 삭제 기능
    - end-to-start로 Todo를 밀면 Todo가 삭제됩니다. 
- Important toggle 
- Completed toggle
    - 체크박스와 텍스트를 `tap`하면 toggle 됩니다.
- Text Edit
    - 텍스트를 `longPress`하면 텍스트 수정 창이 팝업됩니다.
    - 팝업 창에 수정할 텍스트를 입력한 후 우측하단 버튼을 누르면 텍스트가 수정됩니다. 

---
## Day 3

### 구현 내용
- `TabBarView`로 To-Do 상태에 따른 페이지 분리
- 리팩터링
    - Scaffold 구조 개선
        - appbar, body, bottomNavigationBar로 나누어 구현
            - appbar: Appbar (bottom: tabBar)
            - body: TabBarView
            - bottomNavigationBar: addTaskWidget
    - `prefs` StorageService class로 분리
        - todoRepository, todoList도 StorageService로 옮겨 관리할 예정입니다.

--- 
## Day 4

### 구현 내용
- 리팩터링
    - localStorage 관리 부분 `StorageService`로 완전 분리
    - AddTask 위젯 분리
    - StorageService 메서드 로그 추가
    - StorageService 추상 클래스로 변경
        - storage가 교체되는 사용하는 상황 고려
    - StorageServiceImpl 클래스 싱글톤으로 추가
- 버그 수정
    - 앱 첫 진입 시 데이터가 로딩되지 않는 문제
        - `initApp` 비동기 데이터 초기화 이후 `.then()`으로 화면 렌더링 호출
    - Important, Completed 속성 변경 시 간헐적으로 적용되지 않는 문제
        - `StorageService.store()` 호출하여 안정성 개선

--- 
## Day 5

### 구현 내용
- Setting Widget 추가
    - `rotating_icon_button`으로 버튼을 눌렀을 때 아이콘이 회전하도록 시각화
    - 다음 기능을 포함하고 있습니다. 
        - 백업 및 복원
        - 앱 데이터 초기화
- 앱 데이터 초기화
    - 아주 깔끔해집니다.
- 백업 및 복원 구현
    - 백업 버튼을 누르면 사용자의 클립보드에 Backup code를 전달합니다. 
        - 먼저 현재 data를 `Map<String, dynamic>`에 담습니다.
        - 이후 Map을 String 형태로 변환하고, 사용자의 클립보드에 전달합니다. 
    - 복원에서는 사용자가 Backup code를 붙여넣으면 데이터를 코드와 동기화합니다. 
        - TodoService에서 code를 분석, 적절한 형식의 데이터면 `Map<String, dynamic>`으로 나누어 현재 데이터와 동기화합니다.
        - 데이터가 형식에 맞지 않으면 잘못된 Code임을 사용자에게 메시지로 전달합니다. 

---

## Day 6

### 구현 내용
- 리팩터링
    - TodoWidget StatelessWidget으로 리팩터링
- 수정
    - TodoService Backup/Restore 예외 핸들링 강화, 로그 추가
        - FormatException, General Exception을 감지해 로그에 남깁니다. 
    - ThemeData 간소화
        - 안 쓰는 것들 없앴습니다. 
    - Todo 취소선 highlightColor로 색상 변경
- 기능 구현
    - 전체 상호작용에 SnackBar 추가
        - 아래 팝업으로 사용자가 어떤 상호작용을 했는지 알려줍니다.
    - Todo 삭제 복원(Undo) 구현
        - Undo 버튼을 누르면 삭제한 TodoModel이 그대로 복원됩니다.
        - TodoModel를 복원했을 때 순서를 지켜주기 위해 빌드 단계에서 todolist를 정렬합니다. 

--- 
