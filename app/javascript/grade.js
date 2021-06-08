//子要素を選択するフォーム
function add_childSelect_tag() {
  let child_select_form = `
                          <select name="post[grade_id]" id="post_grade_id" class="child_grade_id">
                          <option value="">カテゴリを選択</option>
                          </select>
                          `
  return child_select_form;
}

function add_Option(children) {
  let option_html = `
                    <option value=${children.id}>${children.name}</option>
                    `
  return option_html;
}

//親カテゴリを選択した後のイベント
$("#grade_form").on("change",function () {
  let parentValue = $("#grade_form").val();
  if(parentValue.length !== 0){
    $.ajax({
      url: '/posts/search',
      type: 'GET',
      data: { parent_id: parentValue},
      dataType: 'json'
    })
    .done(function (data) {
      let child_select_form = add_childSelect_tag
      $(".select-box").append(child_select_form);
      data.forEach(function(d) {
        let option_html = add_Option(d)
        $(".child_grade_id").append(option_html)
      });
    })
    .fail(function(){
      alert('カテゴリ取得に失敗しました');
    });
  };
});

//孫要素の選択フォーム
function add_grandchildSelect_tag() {
  let grandchild_select_form = `
                          <select name="post[grade_id]" id="post_grade_id" class="grandchild_grade_id">
                          <option value="">カテゴリを選択</option>
                          </select>
                          `
  return grandchild_select_form;
}

//子カテゴリを選択した後のイベント
$(document).on("change","child_grade_id",function () {
  let childValue = $(".child_grade_id").val();
  if(childValue.length !== 0){
    $.ajax({
      url: '/posts/search',
      type: 'GET',
      data: { children_id: childValue},
      dataType: 'json'
    })
    .done(function (gc_data) {
      let grandchild_select_form = add_grandchildSelect_tag
      $(".select-box").append(grandchild_select_form);
      gc_data.forEach(function(gc_d) {
        let option_html = add_Option(gc_d)
        $(".grandchild_grade_id").append(option_html)
      })
    })
    .fail(function(){
      alert('カテゴリ取得に失敗しました');
    });
  };
});