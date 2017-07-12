<div class="breadcrumb" xmlns:v="http://rdf.data-vocabulary.org/#">
   <?php
   if(isset($breadcrumbs)) {
     $breadcount = count($breadcrumbs) - 1;
     foreach ($breadcrumbs as $iterator => $breadcrumb) {
       if ($iterator != $breadcount) {
         echo $breadcrumb['separator'] . '<span typeof="v:Breadcrumb" class="step1"><a href="' . $breadcrumb['href'] . '" rel="v:url" property="v:title">' . $breadcrumb['text'] . '</a></span>';
       } else {
         echo $breadcrumb['separator'] . $breadcrumb['text'];
       }
     }
   } ?>
  </div>
