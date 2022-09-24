<?php
	$id_category = 1;
?>
<?php
$sql_product = mysqli_query($con,"SELECT * FROM tbl_sanpham ORDER BY sanpham_id DESC");
while($row_sanpham = mysqli_fetch_array($sql_product)){ 
	if($row_sanpham['category_id']==$id_category){
?>
<div class="col-lg-4 col-md-4 col-sm-6 col-6">
	<div class="single-product">
		<div class="pro-img">
			<a href="/{{ product.link }}/">
				<img class="primary-img" src="images/<?php echo $row_sanpham['sanpham_image'] ?>" alt="single-product">
			</a>
		</div>
		<div class="pro-content">
			<div>
				<h3><a href="/{{ product.link }}/"><?php echo $row_sanpham['sanpham_name'] ?></a></h3>
				<p><span class="price"><?php echo number_format($row_sanpham['sanpham_giakhuyenmai']).' đ' ?></span></p>
			</div>
		</div>
	</div>
</div>
<?php
	}
} 
?>