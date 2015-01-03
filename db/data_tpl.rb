module DATA_DEF
DATA_TPL={
template:[
    { name:"Slide Show: Article(news, notices)",
      description:"You only need to provide article type id",
      content:
'
<%######### Define your variables #########%> 
<%# 1:news, 2:notices, 3:invitation slide%> 
<% id= 3 %>
<% bottom_string="" %>
<%######### Do Calculation#########%> 
<% column="title" %> 
<% data=Type.find(3).articles %>   
<%= slide_columns(data,column,bottom_string) %>
'
    },  
    { name:"Slide Show: Gallery photo",
      description:"You only need to provide gallery id",
      content:
'<%######### Define your variables #########%> 
<% id= 10 %>
<% bottom_string="Can be any string" %>
<%######### Do Calculation#########%>     
<%= gallery_photo_slide(id,bottom_string)  %>'
    }, 
    { name:"Slide Show: Gallery photo(Advanced)",
      description:"You can customize the format",
      content:
'<%######### Define your variables #########%>
<% id= 10 %>
<% bottom_string="" %>
<%######### Do Calculation#########%>
<% data=Gallery.find(id).media %>
<%######### Display slide show #########%>
<div sid=data.name class="carousel slide">
  <!-- Carousel items -->
  <div class="carousel-inner">
    <% unless data.blank? %>
      <div class="active item LoanRate">
        <% ele=data.first %>   
        <%= image_tag ele.item.url(:large) %>     
        <%= display(ele.title) %>
      </div>      
    <% end %>
    <% unless data.blank? %>
    <% data.each do |ele| %>   
    <div class="item ">
      <%= image_tag ele.item.url(:large) %>     
      <%= display(ele.title) %>
    </div>
    <% end %>
    <% end %>
  </div>
  <div class="restrict"><%= bottom_string %></div>
  <!-- Carousel nav -->
  <a class="carousel-control left" href="#<%=sid%>" data-slide="prev"><</a>
  <a class="carousel-control right" href="#<%=sid%>" data-slide="next">></a>
</div>
<script type="text/javascript">
  $(function(){ 
     $("#<%=sid%>").carousel({interval: 2000})
  });
</script>'
    },        
    { name:"Children Layout",
      description:"Define Children Layout by providing each column width",
      content: 
'<%######### Define the width for each column.#########%>      
<% columns=[6,1,2] %>
<%######### Do Calculation#########%>
<% data=Widget.find(id).children %>
<% col_num = columns.size %>
<% dat_num = data.size %>
<%######### Display rows #########%>
<% data.each_with_index do |item,index| %>
  <%######### begin of row #########%>
  <% indx = index%col_num %>  
  <% if indx == 0 %><div class="row-fluid"><% end %>
  <% span = columns[indx] %>
  <% spanclass="col-md-#{span}" %> 
  <div class="<%= spanclass %>">
  <%=item.get_content() %>
  </div>
  <%######### end of row #########%>
  <% if index == (dat_num-1) || indx==(col_num-1) %></div><% end %>
<% end %>
<%######### end of all #########%>'
    },  
    { name:'Display db data by fixed columns',
      description:"Split every row into columns",      
      content:
'<%######### Define your variables #########%>
<% data=ViewAdm.all %>
<% columns=["name","action_scope"] %>
<% col = 4 %>
<%######### Do Calculation#########%>
<% span = 12/col %>
<% spanclass="col-md-#{span}" %>
<% size=data.size-1 %>
<%######### Display rows #########%>
<% (0..size).each do |index| %>
  <%######### begin of row #########%>
  <% if index%span == 0 %><div class="row-fluid"><% end %>
  <div class="<%= spanclass %>">
  <% columns.each do |column| %>
    <%= data[index].send(column) %>
  <% end %>
  </div>
  <%######### end of row #########%>
  <% if index == size %></div><% end %>
<% end %>
<%######### end of all #########%>'
    },
    { name:"Carousel: Slide Show",
      description:"Play the data by Slide Show",
      content:
'<%######### Define your variables #########%>
<% data=ViewAdm.all %>
<% columns=["column1","column2"] %>
<% low_string="Some Description" %>
<%######### Do Calculation#########%>
<%######### Display slide show #########%>
<div sid=data.name class="carousel slide">
  <!-- Carousel items -->
  <div class="carousel-inner">
    <div class="active item LoanRate">
      First row</br>
      Second row</br>
   </div>
    <% unless data.blank? %>
    <% data.each do |rate| %>
    <div class="item LoanRate">
       <%= rate.name %></br>
    </div>
    <% end %>
    <% end %>
  </div>
  <div class="restrict"><%= low_string %></div>
  <!-- Carousel nav -->
  <a class="carousel-control left" href="#<%=sid%>" data-slide="prev"><</a>
  <a class="carousel-control right" href="#<%=sid%>" data-slide="next">></a>
</div>
<script type="text/javascript">
  $(function(){ 
     $("#<%=sid%>").carousel({interval: 2000})
  });
</script>'
    },        
    { name:"Static Sample: Row Grid",
      description:"Nested Grid",
      content:
'<div class="row">
    <div class="col-md-4"><div class="well">1<br/><br/><br/><br/><br/></div></div>
    <div class="col-md-8">
        <div class="row">
            <div class="col-md-6"><div class="well">2</div></div>
            <div class="col-md-6"><div class="well">3</div></div>
        </div>
        <div class="row">
            <div class="col-md-6"><div class="well">4</div></div>
            <div class="col-md-6"><div class="well">5</div></div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-4">
        <div class="well">6</div>
    </div>
    <div class="col-md-4">
        <div class="well">7</div>
    </div>
    <div class="col-md-4">
        <div class="well">8</div>
    </div>
</div>'
    },
    { name:"Static Sample:3 columns per row",
      description:"Split every row into 3 columns",
      content: 
'<div class="container">
    <div class="row">
        <div class="col-md-4"><p>Box 1</p></div>
        <div class="col-md-4"><p>Box 2</p></div>
        <div class="col-md-4"><p>Box 3</p></div>
        <div class="clearfix visible-md-block"></div>
        <div class="col-md-4"><p>Box 4</p></div>
        <div class="col-md-4"><p>Box 5</p></div>
        <div class="col-md-4"><p>Box 6</p></div>
        <div class="clearfix visible-md-block"></div>
        <div class="col-md-4"><p>Box 7</p></div>
        <div class="col-md-4"><p>Box 8</p></div>
        <div class="col-md-4"><p>Box 9</p></div>
        <div class="clearfix visible-md-block"></div>
        <div class="col-md-4"><p>Box 10</p></div>
        <div class="col-md-4"><p>Box 11</p></div>
        <div class="col-md-4"><p>Box 12</p></div>
    </div>
</div>'
    },
    { name:"News Index",
      description:"News Index",
      content:
'<% @articles=Article.all %>
      <div id="article-list">
        <% @articles.each do |article| %>
            <hr/>
            <div class="article">
              <%= article.title %>
              <% if article.source_site %>
                <span class="source">
                  <%= "#{article.source_site} | " %>
                </span>
              <% end %>
              <span class="date">
                <%= article.published_on.try(:to_formatted_s, :long) %>
              </span>
              <div class="content">
              </div>
            </div>
        <% end %>
      </div>'
    }    
  ]     
}
end