// app.title = '坐标轴刻度与标签对齐';

option = {
    //saveAsImage: {backgroundColor: '#ffffff'},
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
            data:[198,728,1829,3050,2779,3327,3311,4239,3756,4396,4367,3843,2133,264,24]  //[a,b]
        }
    ]
};
