data=`cat data.txt`

for name in $data
do
    echo $name | tr '[:upper:]' '[:lower:]' > tmp.txt
    model=`cat tmp.txt`

    sed -i 's/0//g' tmp.txt
    sed -i 's/1//g' tmp.txt
    sed -i 's/2//g' tmp.txt
    sed -i 's/3//g' tmp.txt
    sed -i 's/4//g' tmp.txt
    sed -i 's/5//g' tmp.txt
    sed -i 's/6//g' tmp.txt
    sed -i 's/7//g' tmp.txt
    sed -i 's/8//g' tmp.txt
    sed -i 's/9//g' tmp.txt
    
    getname=$(cat tmp.txt)
    if [[ "$getname" == "b" || "$getname" == "bx" ]]
    then
        name="Quạt Bàn Senko $name"
        link="quat-ban-senko-$model"
    elif [[ "$getname" == "bd" ]]
    then
        name="Quạt Bàn Đảo Senko $name"
        link="quat-ban-dao-senko-$model"
    elif [[ "$getname" == "t" || "$getname" == "tc" || "$getname" == "tr" ]]
    then
        name="Quạt Treo Senko $name"
        link="quat-treo-senko-$model"
    elif [[ "$getname" == "dd" || "$getname" == "dcn" || "$getname" == "dh" || "$getname" == "dr" || "$getname" == "dts" ]]
    then
        name="Quạt Đứng Senko $name"
        link="quat-dung-senko-$model"
    elif [[ "$getname" == "l" || "$getname" == "ls" || "$getname" == "lts" ]]
    then
        name="Quạt Lửng Senko $name"
        link="quat-lung-senko-$model"
    elif [[ "$getname" == "h" || "$getname" == "ht" ]]
    then
        name="Quạt Hút Senko $name"
        link="quat-hut-senko-$model"
    else [[ "$getname" == "td" ]]
        name="Quạt Trần Đảo Senko $name"
        link="quat-tran-dao-senko-$model"
    fi

    path="../assets/img/$model"
    path1="\assets\img\{{ model }}"
    pic=$(find $path -type f | wc -l)
    a=1
    ls $path > listfile.txt
    namepic=$(cat listfile.txt | head -$a | tail -1)

    echo "---" >> $link.html
    echo "layout: product-detail" >> $link.html
    echo "title: $name" >> $link.html
    echo "permalink: /$link/" >> $link.html
    echo "---" >> $link.html
    echo '{% assign model = "'$model'" %}' >> $link.html
    echo "{% for product in site.data.san-pham %}" >> $link.html
    echo "  {% if product.model  == model %}" >> $link.html
    echo "      {%- include detail-1.html -%}" >> $link.html
    echo '      <div class="tab-content">' >> $link.html
    echo '                <div id="thumb1" class="tab-pane fade show active">' >> $link.html
    echo '                    <a data-fancybox="images" href="'$path1'\'$namepic'"><img src="'$path1'\active\'${namepic//.webp/}-active.webp'" alt="product-view"></a>' >> $link.html
    echo '                </div>' >> $link.html

    while [ $a -lt $pic ]
    do
        a=`expr $a + 1`
        namepic=$(cat listfile.txt | head -$a | tail -1)
        echo '          <div id="thumb'$a'" class="tab-pane fade">' >> $link.html
        echo '              <a data-fancybox="images" href="'$path1'\'$namepic'"><img src="'$path1'\active\'${namepic//.webp/}-active.webp'" alt="product-view"></a>' >> $link.html
        echo '          </div>' >> $link.html
    done
    echo "      </div>" >> $link.html
    echo '      <div class="product-thumbnail mt-15">' >> $link.html
    echo '          <div class="thumb-menu owl-carousel nav tabs-area" role="tablist">' >> $link.html
    b=0
    while [ $b -lt $pic ]
    do
        b=`expr $b + 1`
        namepic=`cat listfile.txt | head -$b | tail -1`
        echo '              <a class="active" data-toggle="tab" href="#thumb'$b'"><img src="'$path1'\thumb\'${namepic//.webp/}-thumb.webp'" alt="product-thumbnail"></a>' >> $link.html
    done
    echo "          </div>" >> $link.html
    echo "      </div>" >> $link.html
    echo "      {%- include detail-2.html -%}" >> $link.html
    echo "      {%- include detail-3.html -%}" >> $link.html
    echo "                                    <p>TEST CONTENT</p>" >> $link.html
    echo "                                {%- include detail-4.html -%}" >> $link.html
    echo "{% endif %}" >> $link.html
    echo "{% endfor %}" >> $link.html
    mv $link.html ../product-detail/$link.html
    rm -rf listfile.txt
    rm -rf tmp.txt
done