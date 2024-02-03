class Solution {
public:
    void recursive(vector<int> &arr,vector<int> &dp, int cur,int k){
        if(cur==arr.size()+1)return;
        int maxVal=0;
        for(int i=1;cur-i>=0&&i<=k;++i){
            maxVal=max(maxVal,arr[cur-i]);
            dp[cur]=max(dp[cur],dp[cur-i]+maxVal*i);
        }
        recursive(arr,dp,cur+1,k);
    }

    int maxSumAfterPartitioning(vector<int>& arr, int k) {
        vector<int> dp(arr.size()+1,0);
        recursive(arr,dp,0,k);
        return dp.back();
    }
};
