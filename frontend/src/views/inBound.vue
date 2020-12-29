<template>
    <div class="ib_pal">
        <div id="insert_ib">
        <el-input
            size="medium"
            placeholder="订单ID"
            v-model="ibOrder">
        </el-input>
        <el-input
            size="medium"
            placeholder="数量"
            v-model="ibAmount">
        </el-input>
        <el-input
            size="medium"
            placeholder="时间"
            v-model="ibDate">
        </el-input>
        <el-input
            size="medium"
            placeholder="家具ID"
            v-model="furId">
        </el-input>
        <el-input
            size="medium"
            placeholder="供应商ID"
            v-model="supId">
        </el-input>
        <el-input
            size="medium"
            placeholder="进货价格"
            v-model="ibPrice">
        </el-input>
        <el-button type="primary" plain @click="insertIb" id="ib_inser_btn">插入</el-button>
        </div>
        <el-alert
            id="alert"
            title="提交错误！！请检查输入信息！！"
            type="error"
            center
            show-icon
            v-show="alert"
            closable=true>
        </el-alert>
        <el-table
        :data="ibs"
        border
        id="ibtable">
        <el-table-column
            prop="ib_order"
            label="进货订单号"
            width="150">
        </el-table-column>
        <el-table-column
            prop="ib_amount"
            label="进货数量"
            width="120">
        </el-table-column>
        <el-table-column
            prop="ib_date"
            label="进货时间"
            width="150">
        </el-table-column>
        <el-table-column
            prop="fur_id"
            label="进货家具"
            width="120">
        </el-table-column>
        <el-table-column
            prop="sup_id"
            label="供应商"
            width="120">
        </el-table-column>
        <el-table-column
            prop="ib_price"
            label="进货价格"
            width="120">
        </el-table-column>
        <el-table-column
            label="操作"
            width="150">
            <el-button type="primary" icon="el-icon-edit" plain></el-button>
            <el-button type="primary" icon="el-icon-delete" plain></el-button>
        </el-table-column>
        </el-table>
        <div class="block">
        <el-date-picker
            v-model="stedDate"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期">
        </el-date-picker>
        <el-button id="get_io_btn" type="primary" plain @click="getIO">查询</el-button>
        </div>
        <el-table
        :data="ios"
        v-show="iotables"
        border
        id="iotable">
        <el-table-column
            prop="fur_id"
            label="家具编号"
            width="120">
        </el-table-column>
        <el-table-column
            prop="total_in"
            label="总进货"
            width="150">
        </el-table-column>
        <el-table-column
            prop="total_out"
            label="总销售"
            width="150">
        </el-table-column>
        </el-table>
    </div>
</template>
<script>
import axios from 'axios'

export default {
  name: 'inBound',
  data: function(){
    return{
      ibs: [],
      stedDate: [],
      ios:[],
      iotables:0,
      ibOrder:'',
      ibAmount:'',
      ibDate:'',
      furId:'',
      supId:'',
      ibPrice:'',
    }
  },
  mounted: function() {
    axios.get('http://niziqi.top:5000/ib')
      .then((res)=>{
        console.log(res.data)
        this.ibs = res.data
      })
  },
  methods:{
      showIb:function() {
        axios.get('http://niziqi.top:5000/ib')
        .then((res)=>{
        console.log(res.data)
        this.ibs = res.data
      })
      },
      getIO:function(){
          this.iotables=1
          let stdate = this.DateToString(this.stedDate[0])
          let eddate = this.DateToString(this.stedDate[1])
          axios.get('http://niziqi.top:5000/getTotalIO',{
          params:{
            stDate: stdate,
            edDate: eddate
          }})
          .then((res)=>{
              console.log(res.data)
              this.ios = res.data
          }
          )
      },
      DateToString:function (date){ 
        let  year = date.getFullYear()
        let  month =(date.getMonth() + 1).toString() 
        let  day = (date.getDate()).toString()  
        if  (month.length == 1) { 
            month =  "0"  + month 
        } 
        if  (day.length == 1) { 
            day =  "0"  + day
        }
        let  dateTime = year +  "-"  + month +  "-"  + day
        return  dateTime
      },
    insertIb:function(){
      axios.post('http://niziqi.top:5000/insertIb',{
        furId:this.furId,
        ibOrder:this.ibOrder,
        ibAmount:this.ibAmount,
        ibPrice:this.ibPrice,
        ibDate:this.ibDate,
        supId:this.supId
      }).then(
        this.showIb()
      ).catch(
        this.$alert('注意提交正确的信息！！', '插入错误！', {
          confirmButtonText: '确定',
        }))
    }
  }
}
</script>
<style scoped>
.el-input {
    margin-left: 5px;
}
.ib_pal {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
.block {
    margin-top: 60px;
}
#get_io_btn {
    margin-left: 10px;
}
#insert_ib {
  margin-top: 70px;
  width:100%;
  display: flex;
  align-items: center;
}
#ib_inser_btn {
    margin-left: 10px;
}
#ibtable {
  margin-top: 30px;
  font-size: 18px;
  max-width: 931px;
}
#iotable {
  margin-top: 30px;
  font-size: 18px;
  max-width: 421px;
}
#insert_ib {
  margin-top: 70px;
  width:50%;
  display: flex;
}
</style>