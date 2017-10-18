// app.title = '坐标轴刻度与标签对齐';

option = {
    backgroundColor: '#ffffff',
    color: ['#3398DB'],
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : ['1-2年','2-3年','3-4年','4-5年','5-6年','6-7年','7-8年','8-9年','9-10年','10-11年','11-12年','12-13年','13-14年','14-15年','15年以上'], //[a,b]
            axisTick: {
                alignWithLabel: true
            }
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'直接访问',
            type:'bar',
            barWidth: '60%',
            data:[128,726,778,1248,1293,1867,2666,3028,3368,2530,2918,3003,2317,1921,2491]  //[a,b]
        }
    ]
};
