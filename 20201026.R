
# Run.R -------------------------------------------------------------------

rm(list = ls())
library(tidyverse)
library(readxl)
library(writexl)
library(stringi)
library(openxlsx)
source("functions.R")

# Reading Data ------------------------------------------------------------

JIS_list<-read_xlsx("20200619_JIS一覧.xlsx",sheet=2) %>% 
  select(.,-1) %>% 
  rename(スタンダード_ナンバー = "スタンダード・ナンバー")

#kakasi
JIS_kakasi<-read_xlsx("out3.xlsx",sheet=1)
JIS_list$標準文字_クレンジング後<-JIS_kakasi$res2
JIS_list$標準文字_クレンジング後<-stri_trans_nfkc(JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("\\("," ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("\\)","",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("、"," ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub(" - "," ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub(","," ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("-"," ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("  "," ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("45 ゜エルボ","45°エルボ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("90 ゜エルボ","90°エルボ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("180 ゜エルボ","180°エルボ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("‐"," ",JIS_list$標準文字_クレンジング後)

#write.csv(JIS_list,"JIS_list_rev.csv")
JIS_list<-read.csv("rev_JIS_list.csv")
colnames(JIS_list)<-c("スタンダード_ナンバー","標準文字","標準文字_クレンジング後")
JIS_list$標準文字_クレンジング後<-gsub("ヨビケイロッカクボルト","ヨビケイ ロッカクボルト",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("ゼンネジロッカクボルト","ゼンネジ ロッカクボルト",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("ユウコウケイロッカクボルト","ユウコウケイ ロッカクボルト",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("I カタチコウ","Iカタチコウ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("ケイチガイニップル","ケイチガイ ニップル",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("ケイチガイメスオスソケット","ケイチガイ メスオスソケット",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("ケイチガイソケット","ケイチガイ ソケット",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("ケイチガイクロス","ケイチガイ クロス",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("ケイチガイエルボ","ケイチガイ エルボ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("Aシュ","Aタネ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("Bシュ","Bタネ",JIS_list$標準文字_クレンジング後)
JIS_list$標準文字_クレンジング後<-gsub("Cシュ","Cタネ",JIS_list$標準文字_クレンジング後)


colnames(JIS_list)
JIS_list_distinct<-distinct(JIS_list,スタンダード_ナンバー ,標準文字_クレンジング後,.keep_all = T)
dim(JIS_list_distinct)

#文字分割
name_mat<-data.frame(matrix(NA,nrow(JIS_list_distinct),7,dimnames = list(c(),c("meisyou",paste0("name",1:6)))))
for(i in 1:nrow(JIS_list_distinct)){
  #i<-1
  tmp<-str_split(string =  JIS_list_distinct$標準文字_クレンジング後[i],
                 pattern = c(" "), n = Inf)
  name_mat[i,1]<-tmp[[1]][1]
  name_mat[i,2]<-tmp[[1]][2]
  name_mat[i,3]<-tmp[[1]][3]
  name_mat[i,4]<-tmp[[1]][4]
  name_mat[i,5]<-tmp[[1]][5]
  name_mat[i,6]<-tmp[[1]][6]
  name_mat[i,7]<-tmp[[1]][7]
  
}


JIS_list_distinct<-cbind(JIS_list_distinct,name_mat) 
JIS_list_distinct$meisyou<-str_trim(JIS_list_distinct$meisyou, side = "both")

tmp<-read.csv("JIS名称分割結果.csv")
key<-tmp$key
JIS_list_distinct$key<-key
#key項目を先頭に持ってくる
for(i in 1:nrow(JIS_list_distinct)){
  if(JIS_list_distinct$key[i]==2){
    tmp<-JIS_list_distinct$meisyou[i]
    JIS_list_distinct$meisyou[i]<-JIS_list_distinct$name1[i]    
    JIS_list_distinct$name1[i]<-tmp
  }
  if(JIS_list_distinct$key[i]==3){
    tmp<-JIS_list_distinct$meisyou[i]
    JIS_list_distinct$meisyou[i]<-JIS_list_distinct$name2[i]    
    JIS_list_distinct$name2[i]<-tmp
  }
}

#全社まとめ -------------------------------------------------------------------------

target <-read.csv("品目データ(全社まとめ)JIS突当除外追記.csv",encoding='Shift_JIS',na="")%>% 
  filter(.,!is.na(品目名称)) 
target$品目名称仕様<-ifelse(is.na(target$仕様),target$品目名称,paste(target$品目名称,target$仕様,sep=" "))

colnames(target)
dim(target2)
# -------------------------------------------------------------------------
#品目名称仕様
target<-read.csv("クレンジング途中_kakasi.csv")
target <- target %>% 
  filter(.,JIS突当除外!="×") %>% 
  filter(.,!is.na(品目名称)) %>% 
  select(.,-1)

colnames(target)[6]<-"自社品目番号"

target$仕様
target$res
target$name_1<-stri_trans_nfkc(target$res)


#文字の置き換え
target$name_2<-target$name_1
target$name_2<-gsub("6カクボルト","ロッカクボルト",target$name_2)
target$name_2<-gsub("ボルト6カク","ロッカクボルト",target$name_2)
target$name_2<-gsub("ボルト 6カク","ロッカクボルト",target$name_2)
target$name_2<-gsub("6カクナット","ロッカクナット",target$name_2)
target$name_2<-gsub("6カクアナツキボタン","ロッカクアナツキボタン",target$name_2)
target$name_2<-gsub("6カクアナツキ","ロッカクアナツキ",target$name_2)
target$name_2<-gsub("ボルト(6カクアナツキ)","ロッカクアナツキボルト",target$name_2)
target$name_2<-gsub("ナット6カク","ロッカクナット",target$name_2)
target$name_2<-gsub("ナガニップル","ロングニップル",target$name_2)
target$name_2<-gsub("ニップルナガ","ロングニップル",target$name_2)
target$name_2<-gsub("ニップル\\.ナガ","ロングニップル",target$name_2)
target$name_2<-gsub("ニップル\\.ナガ","ロングニップル",target$name_2)
target$name_2<-gsub("エルボ 45゜","45°エルボ",target$name_2)
target$name_2<-gsub("ヨウセツナット6カク","ロッカクヨウセツナット",target$name_2)
target$name_2<-gsub("ジュウジアナツキナベコネジ","ジュウジアナツキナベショウネジ",target$name_2)
target$name_2<-gsub("ティ-","ティー",target$name_2)
target$name_2<-gsub("ザガネ ヒラ","タイラザガネ",target$name_2)
target$name_2<-gsub("ザガネ バネ","バネザガネ",target$name_2)
target$name_2<-gsub("ハ-フカップリング","ハーフカップリング",target$name_2)
target$name_2<-gsub("チョウニップル","ロングニップル",target$name_2)
target$name_2<-gsub("ザガネバネ","バネザガネ",target$name_2)
target$name_2<-gsub("ザガネヒラ","タイラザガネ",target$name_2)
target$name_2<-gsub("ヒラザガネ","タイラザガネ",target$name_2)
#target$name_2<-gsub("イケイティー","ケイチガイティー",target$name_2)
#target$name_2<-gsub("エルボ イケイ","ケイチガイエルボ",target$name_2)
#target$name_2<-gsub("ティー イケイ","ケイチガイティー",target$name_2)
target$name_2<-gsub("イケイ","ケイチガイ",target$name_2)


#クレンジング　特殊文字の削除
target$name_3<-target$name_2
target$name_3<- gsub("(^\\(.*?)(\\))","",target$name_3)
target$name_3<-string_replace(target$name_3,"、",",")
target$name_3<-gsub("※","",target$name_3)
target$name_3<-gsub("\\*","",target$name_3)
target$name_3<-gsub("\\+","",target$name_3)
target$name_3<-gsub("^\\(\\+\\)","",target$name_3)
target$name_3<-gsub("\\("," ",target$name_3)
target$name_3<-gsub("\\)","",target$name_3)
target$name_3<-gsub("〉","",target$name_3)
target$name_3<-gsub("〈"," ",target$name_3)
target$name_3<-gsub("】","",target$name_3)
target$name_3<-gsub("【"," ",target$name_3)
target$name_3<-gsub("〔"," ",target$name_3)
target$name_3<-gsub("〕","",target$name_3)
target$name_3<-gsub(">","",target$name_3)
target$name_3<-gsub("<","",target$name_3)
target$name_3<-gsub("・","",target$name_3)
target$name_3<-gsub("\\."," ",target$name_3)
target$name_3<-gsub("-","ー",target$name_3)


#例外処理
target$meisyou<-target$name_3
#target[target$meisyou=="",]
#target$meisyou<-ifelse(target$meisyou=="",target$name_2,target$meisyou)


# JIS確認 -------------------------------------------------------------------
# JISが含まれる品目数(JIS10Kなども含む)
idx<-sum(str_detect(target$meisyou,"jis"))
sum(idx)
idx<-str_detect(target$meisyou,"JIS")
sum(idx)
colnames(target)
tmp<-as.data.frame(target[idx,c("自社品目番号","meisyou")])
# 空白の削除
tmp$blunk_rm<-gsub(" ", "", tmp$meisyou, fixed = TRUE)

# JIS一覧の検索
JIS_vec<-data.frame(スタンダード_ナンバー=unique(JIS_list$スタンダード_ナンバー))
JIS_vec$blunk_rm<-gsub(" ", "", JIS_vec$スタンダード_ナンバー, fixed = TRUE)
JIS_vec<-distinct(JIS_vec,スタンダード_ナンバー,.keep_all=T)

number<-numeric()
df<-data.frame()
for(i in 1:nrow(JIS_vec)){
  idx<-str_detect(tmp$blunk_rm,JIS_vec$blunk_rm[i])
  number[i]<-sum(idx)
  if(number[i]>0){
    temp<-tmp[idx,]
    temp$スタンダード_ナンバー<-JIS_vec$スタンダード_ナンバー[i]
    df<-rbind(df,temp)
  }
}


# JISで突合できた品目
df<- df %>% inner_join(.,JIS_list_distinct,by="スタンダード_ナンバー")
unique.data.frame(df)
res_only_JIS<- df %>% inner_join(.,target,by="自社品目番号") 
#colnames(res_only_JIS)[1:5]<-c("自社品目番号","品目名称","仕様","工場名","大分類")

#target残り
left_target<- target %>%  anti_join(.,res_only_JIS,"自社品目番号")


# 標準文字を使う-------------------------------------------------------------------------


tmp<-numeric()
idx_mat<-matrix(0,nrow(left_target),nrow(JIS_list_distinct))

for(i in 1:nrow(JIS_list_distinct)){
  idx<-rep(0,nrow(left_target))
  idx<-as.numeric(str_detect(left_target$meisyou,JIS_list_distinct[i,4]))
  idx_mat[,i]<-idx
}

num_JIS_candidate<-numeric(nrow(left_target))
for (i in 1:nrow(left_target)) {
  #i<-43
  num_JIS_candidate[i]<-length(unique(JIS_list_distinct$スタンダード_ナンバー[idx_mat[i,]>0]))
}

res<-left_target
res$JIS番号候補数<-num_JIS_candidate

#標準文字あり
nrow(res[which(res$JIS番号候補数>0),])

#JIS番号の候補が一つ
nrow(res[res$JIS番号候補数==1,])

#JIS番号の複数
res_tmp<-res[res$JIS番号候補数>0,]
res_tmp<-res_tmp[res_tmp$JIS番号候補数!=1,]
nrow(res_tmp)

#標準文字でマッチングがなかったもの
nrow(res[which(res$JIS番号候補数==0),])
sum(apply(idx_mat,1,sum)==1)


NewWb <- createWorkbook()
addWorksheet(wb = NewWb, sheetName = "標準文字でマッチングがなし")
writeData(wb = NewWb, sheet = "標準文字でマッチングがなし", x = res[res$JIS番号候補数==0,])


# -------------------------------------------------------------------------


#キー項目であたった品目に対して標準文字のスペックで当てる

next_target<-res[res$JIS番号候補数>0,]
next_target$JIS番号候補数

a<-idx_mat[which(apply(idx_mat,1,sum)>0),]
res.list<-vector("list",nrow(next_target))

for(tr in 1:nrow(next_target)){
  tmp<-JIS_list_distinct[which(a[tr,]>0),]
  spec_mat<-matrix(0,nrow(tmp),5)
  for(k in 1:nrow(tmp)){
    #k<-4
    for(i in 1:5){
      #i<-1
      if(is.na(JIS_list_distinct[which(a[tr,]>0),i+4][k])) next
      spec_mat[k,i]<-str_detect(next_target[tr,]$meisyou,JIS_list_distinct[which(a[tr,]>0),i+4][k])
    }
  }
  #spec matの何列目が候補かvectorで持っている
  idx<-which(apply(spec_mat,1,sum)==max(apply(spec_mat,1,sum)))
  res.list[[tr]]<-JIS_list_distinct[which(a[tr,]>0),][idx,]
}    


#スペックで当たり、標準文字確定した品目
#sum(sapply(res.list,nrow)==1)

next_target<-data.frame(next_target)
df<-data.frame()
#標準文字が1つに確定しても、JIS番号が複数ある場合があるので確認
check<-numeric()
idx<-which(sapply(res.list,nrow)==1)
for(i in 1:nrow(next_target[idx,])){
  #i<-2
  tmp<-res.list[[idx[i]]]
  temp<-JIS_list_distinct %>% inner_join(.,tmp,by="meisyou")
  check[i]<-length(unique(temp$スタンダード_ナンバー.x))
  #df<-rbind(df,temp)
}

res1<-cbind(next_target[which(sapply(res.list,nrow)==1),],df)
#write.csv(res1,"tmp.csv")  


























#スペックで当てても、標準文字複数候補
res4<-next_target[which(sapply(res.list,nrow)!=1),]
ind<-which(sapply(res.list,nrow)!=1)
JIS_condidate<-character()
JIS_condidate_num<-numeric()

if(F){
  ###標準文字の候補を出す
  res4
  idx<-which(sapply(res.list,nrow)!=1)
  res_hm<-data.frame()
  for(i in 1:nrow(res4)){
    tmp.df<-data.frame()
    for(j in 1:nrow(res.list[[idx[i]]])){
      tmp.df<-rbind(res4[i,],tmp.df)
    }
    tmp2<-cbind(tmp.df,res.list[[idx[i]]])
    res_hm<-rbind(res_hm,tmp2)
  }
  #write.csv(res_hm,"hyozyumoji_candidate.csv")
}
####

for(i in 1:nrow(res4)){
  #i<-456
  JIS_condidate_num[i]<-length(unique(res.list[[ind[i]]]$standard_number))
  if(JIS_condidate_num[i]==1){
    JIS_condidate[i]<-unique(res.list[[ind[i]]]$standard_number)
  }else{
    JIS_condidate[i]<-NA
  }
}

res4$JIS_condidate<-JIS_condidate
res4$JIS_condidate_num<-JIS_condidate_num
res5<-res4 %>% select(.,-candidate_num,-name_1,-name_2,-name_3)
colnames(res5)

addWorksheet(wb = NewWb, sheetName = "標準名が複数")
writeData(wb = NewWb, sheet = "標準名が複数", x = res5)


# -------------------------------------------------------------------------


#標準文字とBOM名を選択
colnames(res5)[7]<-"standard_number"
res_check<-data.frame()
idx<-which(res5$JIS_condidate_num==1)
for(i in 1:nrow(res5)){
  #i<-2
  if(i%in%idx){
    tmp<-res5[idx[i],]
    res_check<-rbind(res_check,tmp %>% inner_join(.,JIS_list,by="standard_number"))
    #write.csv(tmp %>% inner_join(.,JIS_list,by="standard_number"),"六角ボルト_JIS番号のみ確定.csv",na="")
  }
}
#write.csv(res_check,"JIS番号のみ確定_標準文字_BOM名選択.csv",na="")



# -------------------------------------------------------------------------
#キー項目とスペックで当たり、標準文字確定した品目
#BOM名による突合を行う
res2<-res1[,c(-6,-7,-8,-13,-15,-16,-17,-18,-19,-20,-21)]  
colnames(res2)[9:10]<-c("h_name","JIS_meisyou")

JIS_list<-read_xlsx("20200619_JIS一覧.xlsx",sheet=2) %>% 
  select(.,-1) %>% 
  rename(standard_number = "スタンダード・ナンバー",
         name = 標準文字,
         BOM_name = BOM名)
#kakasi
JIS_kakasi<-read_xlsx("out3.xlsx",sheet=1)
JIS_list$name_1<-JIS_kakasi$res
colnames(JIS_list)[2]<-c("h_name")

# -------------------------------------------------------------------------

#BOM名の分割

#文字分割
name_mat<-data.frame(matrix(NA,nrow(JIS_list),9,dimnames = list(c(),paste0("split",1:9))))
JIS_list$BOM_name2<-JIS_list$BOM_name
JIS_list$BOM_name2<-gsub("-"," ",JIS_list$BOM_name2)
JIS_list$BOM_name2<-gsub("x"," ",JIS_list$BOM_name2)
JIS_list$BOM_name2<-gsub("   "," ",JIS_list$BOM_name2)

for(i in 1:nrow(JIS_list)){
  #i<-3
  tmp<-str_split(JIS_list$BOM_name2[i],JIS_list$standard_number[i])
  tmp<-str_trim(tmp[[1]][2], side = "both")
  tmp<-str_split(string =  tmp,pattern = c(" "), n = Inf)
  name_mat[i,1]<-tmp[[1]][1]
  name_mat[i,2]<-tmp[[1]][2]
  name_mat[i,3]<-tmp[[1]][3]
  name_mat[i,4]<-tmp[[1]][4]
  name_mat[i,5]<-tmp[[1]][5]
  name_mat[i,6]<-tmp[[1]][6]
  name_mat[i,7]<-tmp[[1]][7]
  name_mat[i,8]<-tmp[[1]][8]
  name_mat[i,9]<-tmp[[1]][9]
}
JIS_list<-cbind(JIS_list,name_mat)



#標準名称のスペックと同じ方法で当てる -------------------------------------------------------------------------


res.list<-vector("list",nrow(res2))

for(tr in 1:nrow(res2)){
  # tr<-70
  tmp<-res2[tr,]
  bom_condidate<-tmp %>% inner_join(.,JIS_list,by=c("standard_number","h_name")) %>% 
    select(number,name,spec,factory,category,meisyou,standard_number,h_name,BOM_name,name_1,
           split1,split2,split3,split4,split5,split6,split7,split8,split9)
  bom_spec<-bom_condidate[,c(8:ncol(bom_condidate))]
  
  spec_mat<-matrix(0,nrow(bom_condidate),9)
  
  for (k in 1:nrow(bom_condidate)) {
    #k<-1
    for(i in 1:9){
      #i<-4
      if(is.na(bom_spec[k,i+3])) next
      spec_mat[k,i]<-str_detect(res2$meisyou[tr],bom_spec[k,i+3])
    }
  }    
  #spec matの何列目が候補か
  idx<-which(apply(spec_mat,1,sum)==apply(bom_spec[,c(4:ncol(bom_spec))],1,function(x)sum(!is.na(x))))
  if(length(idx)==0){
    res.list[[tr]]<-bom_condidate
  }else{
    res.list[[tr]]<-bom_condidate[idx,]
  }
  #idx<-which(apply(spec_mat,1,sum)==max(apply(spec_mat,1,sum)))
}    

res_bom<-data.frame()
idx<-sapply(res.list,nrow)
for(i in 1:length(res.list)){
  if(idx[i]!=1){
    res_bom<-rbind(res_bom,res.list[[i]][1,])
    res_bom$BOM_name[i]<-NA
  }else{
    res_bom<-rbind(res_bom,res.list[[i]])
  }
}

##BOM名と一対一(最終確認)
res_bom2<-res_bom %>% 
  select(.,number,name,spec,category,meisyou,standard_number,h_name,name_1,BOM_name)
res_bom2$BOM_name_candidate_num<-idx
colnames(res_bom2)

addWorksheet(wb = NewWb, sheetName = "BOM名が確定")
writeData(wb = NewWb, sheet = "BOM名が確定", x = res_bom2)

##BOM名のみ選択
res_bom<-data.frame()
idx<-sapply(res.list,nrow)
for(i in 1:length(res.list)){
  #i<-1
  if(idx[i]!=1){
    res_bom<-rbind(res_bom,res.list[[i]])
  }
}
#dim(res_bom)
addWorksheet(wb = NewWb, sheetName = "BOM名を選択")
writeData(wb = NewWb, sheet = "BOM名を選択", x = res_bom)

#saveWorkbook(wb = NewWb, file = "res_20200914.xlsx")


# -------------------------------------------------------------------------



#BOM名も一対一で仮決まる
dim(res2[which(sapply(res.list,nrow)==1),])

#BOM名複数
dim(res2[which(sapply(res.list,nrow)!=1),])
#全候補数(目検がいる)
sum(sapply(res.list,nrow)[which(sapply(res.list,nrow)!=1)])

res_bom_print<-select(res_bom,number,name,category,meisyou,standard_number,h_name,name_1,BOM_name)

#saveWorkbook(wb = NewWb, file = "res_20200909_4.xlsx")
