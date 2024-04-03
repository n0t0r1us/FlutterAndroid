
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NguoiMau{
   String ten;
   String url;

  NguoiMau(this.ten, this.url);
}
NguoiMau nm1 = NguoiMau("Việt Nam", "https://media.doisongvietnam.vn/u/rootimage/editor/2019/08/31/13/32/w825/tuo1567211524_3309.jpg");
NguoiMau nm2 = NguoiMau("Thanh Hoá", "https://truyenhinhthanhhoa.qltns.mediacdn.vn/458221966042468352/2022/11/2/vu-ha-3212-1667367799328-16673677994361590095690.jpeg");
NguoiMau nm3 = NguoiMau("Thuỷ Tiên", "https://www.giaoduc.edu.vn/upload/images/2010/09/30/elizabeth-thuy-tien-cham-thi-vns-next-top-model_1.jpg");
NguoiMau nm4 = NguoiMau("Idonexia", "https://znews-photo.zingcdn.me/w660/Uploaded/neg_yslewlx/2022_04_18/pic.jpg");
NguoiMau nm5 = NguoiMau("English", "https://i.9mobi.vn/cf/images/sa/2019/10/24/hinh-anh-nguoi-dep-cho-dien-thoai-9.jpg");
NguoiMau nm6 = NguoiMau("Philippin", "https://afamilycdn.com/150157425591193600/2021/12/9/2648758772135069542704055043737419625680809n-1639037602575653986031.jpg");
NguoiMau nm7 = NguoiMau("Phương Anh", "https://photo-cms-plo.epicdn.me/w850/Uploaded/2023/wopsvun/2021_04_13/ahauphuonganh_csln.jpg");
NguoiMau nm8 = NguoiMau("Tường San", "https://image-us.eva.vn/upload/1-2020/images/2020-02-07/untitled-1-1581048890-547-width600height750.jpg");
NguoiMau nm9 = NguoiMau("Lan Hương", "https://i.vietgiaitri.com/2018/7/1/le-ly-lan-huong-lot-xac-xinh-dep-va-truong-thanh-7cfb78.jpg");
NguoiMau nm10 = NguoiMau("Ribi", "https://hosonhanvat.vn/wp-content/uploads/2020/03/tieu-su-ribi-sachi-9303.jpg");
NguoiMau nm11 = NguoiMau("An Vy", "https://ss-images.saostar.vn/2019/09/22/6093905/54523494_2287200418232074_4193553046443130880_n.jpg");
NguoiMau nm12 = NguoiMau("Quỳnh Anh", "https://icdn.24h.com.vn/upload/3-2022/images/2022-07-20/qa--4--1658291002-782-width650height1158.jpg");
NguoiMau nm13 = NguoiMau("Kim Ngân", "https://vothisaucamau.edu.vn/wp-content/uploads/2023/01/1674107296_952_Kim-Ngan-Fap-TV-La-Ai-Tieu-Su-Nu-Dien.jpg");
NguoiMau nm14 = NguoiMau("Trung Quốc", "https://danviet.mediacdn.vn/2020/7/1/u5-15935680709581348231404.jpg");
NguoiMau nm15 = NguoiMau("Thị Hà", "https://nld.mediacdn.vn/2020/12/19/hoa-hau-do-thi-ha-9-16083440684032031661253.jpg");
NguoiMau nm16 = NguoiMau("Mỹ Linh", "https://thethaovanhoa.mediacdn.vn/Upload/qPf4BjfjvkrFearu8hrw/files/2020/06/Hoa%20Hau%20Do%20My%20Linh%20(5)%20(1).jpg");
NguoiMau nm17 = NguoiMau("Hoa Hậu", "https://media1.nguoiduatin.vn/media/le-thi-anh-tuyet/2022/10/23/nguyen-phuong-anh.jpg");
NguoiMau nm18 = NguoiMau("Bé Quyên", "https://images.kienthuc.net.vn/zoomh/800/uploaded/dinhcuc/2022_12_21/quyen/voc-dang-goi-cam-cua-be-quyen-thi-hoa-hau-viet-nam-2022.jpg");
NguoiMau nm19 = NguoiMau("Hiền Phương", "http://baohagiang.vn/file/4028eaa4679b32c401679c0c74382a7e/122022/tr_20221201151922.jpg");
NguoiMau nm20 = NguoiMau("Sinh viên Việt Nam", "https://afamilycdn.com/zoom/480_300/150157425591193600/2022/11/10/ha-phuong-16680527828631049525104-1668063267078-1668063267136469170393-54-0-460-650-crop-1668063290265743970284.jpeg");
NguoiMau nm21 = NguoiMau("Thảo Uyên", "https://image-us.eva.vn/upload/4-2018/images/2018-10-17/a-hau-1-cuoc-thi-hoa-hau-the-gioi-nguoi-viet-canada-goi-ten-thi-sinh-chau-ngoc-thao-uyen-1-1539794440-585-width660height990.jpg");
List<NguoiMau> listNM = [nm1,nm2,nm3,nm4,nm5,nm6,nm7,nm8,nm9,nm10,nm11,nm12,nm13,nm14,nm15,nm16,nm17,nm18,nm19,nm20,nm21];

class Grid extends StatelessWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Người Mẫu"),
      ),
      body: GridView.extent(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right:5),
        maxCrossAxisExtent: 250,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.8,
        children: List.generate(listNM.length,
                (index) => GestureDetector(
                  child: Container(
                    child: Image.network(listNM[index].url,),

                  ),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (context) => Show(),);
                    Navigator.push(context, route);
                  },
                )
        ),


      ),
    );
  }
}







class Show extends StatefulWidget {
  const Show({Key? key}) : super(key: key);
  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Người Mẫu"),
      ),
      body: Center(
        child: Center(
          child: CarouselSlider.builder(
              itemCount: listNM.length,
              itemBuilder: (context, index, realIndex) => Container(
                child: Image.network(listNM[index].url,
                fit: BoxFit.contain,),
              ),
              options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 1,
                initialPage: 1,
          ),
          )
        ),
      ),
    );
  }
}