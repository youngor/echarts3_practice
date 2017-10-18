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
            type : 'value',
            axisLabel : {
                formatter: function(value) {
                    return value+"%"; 
                }
            }
        }
    ],
    series : [
        {
            name:'直接访问',
            type:'bar',
            barWidth: '60%',
            data:[0.4,2.3,2.5,4.1,4.2,6.1,8.8,9.9,11.1,8.3,9.6,9.9,7.6,6.3,8.2]  //[a,b]
        }
    ]
};
