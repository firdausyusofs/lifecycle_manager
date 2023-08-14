package com.fy.lifecycle_manager

import com.fy.lifecycle_manager.listener.LifecycleEventListener
import com.fy.lifecycle_manager.manager.LifecycleManager
import com.fy.lifecycle_manager.model.Lifecycle

class LifecycleService: LifecycleEventListener {

    init {
        LifecycleManager.startListeners()
    }

    companion object {
        fun getAppLifeCycle(): Lifecycle {
            return LifecycleManager
                .getAppLifecycle()
        }
    }

    override fun onNewLifecycleEvent(lifecycle: Lifecycle) {
        TODO("Not yet implemented")
    }

}