<template>
  <div id="app">
    <header>
    <el-menu :default-active="$route.path" class="el-menu-demo" mode="horizontal" @select="handleSelect" router>
      <el-menu-item index="/">家具信息管理</el-menu-item>
      <el-submenu index="2">
        <template slot="title">订单信息管理</template>
        <el-menu-item index="/ob">销售管理</el-menu-item>
        <el-menu-item index="/ib">入库管理</el-menu-item>
      </el-submenu>
      <el-menu-item index="/showCus">客户管理</el-menu-item>
    </el-menu>
    <div class="line"></div>
    </header>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'App',
  components: {
    
  },
}
</script>

<style>
* {
  margin: 0;
  padding: 0;
}
header {
  width: 100%;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
}
</style>
